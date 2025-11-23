# main.py
from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware
import subprocess
import os
import uuid
import logging
from pathlib import Path

# 로깅 설정
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

# CORS 설정 (Flutter 앱에서 접근 가능하도록)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 임시 파일 저장 디렉토리
TEMP_DIR = Path("temp")
TEMP_DIR.mkdir(exist_ok=True)

@app.post("/convert-skp-to-glb")
async def convert_skp_to_glb(file: UploadFile = File(...)):
    """SKP 파일을 GLB로 변환"""

    # 파일 확장자 확인
    if not file.filename.endswith('.skp'):
        raise HTTPException(status_code=400, detail="SKP 파일만 업로드 가능합니다.")

    # 고유 파일명 생성
    file_id = str(uuid.uuid4())
    skp_path = TEMP_DIR / f"{file_id}.skp"
    glb_path = TEMP_DIR / f"{file_id}.glb"

    try:
        # SKP 파일 저장
        with open(skp_path, "wb") as f:
            content = await file.read()
            f.write(content)

        # Python 스크립트로 변환 (assimp + Blender)
        result = subprocess.run(
            [
                "python3",
                "convert_skp_to_glb.py",
                str(skp_path),
                str(glb_path)
            ],
            capture_output=True,
            text=True,
            timeout=300  # 5분 타임아웃
        )

        # 항상 변환 출력을 로그에 출력
        print(f"🔍 Converter stdout:\n{result.stdout}", flush=True)
        print(f"🔍 Converter stderr:\n{result.stderr}", flush=True)
        print(f"🔍 Converter returncode: {result.returncode}", flush=True)

        if result.returncode != 0:
            error_msg = f"❌ Conversion failed with returncode: {result.returncode}"
            print(error_msg, flush=True)
            raise HTTPException(
                status_code=500,
                detail=f"변환 실패: {result.stderr}"
            )

        # GLB 파일이 생성되었는지 확인
        if not glb_path.exists():
            error_msg = f"❌ GLB file not created at {glb_path}\n❌ Blender stdout: {result.stdout}\n❌ Blender stderr: {result.stderr}"
            print(error_msg, flush=True)
            raise HTTPException(
                status_code=500,
                detail="GLB 파일 생성 실패"
            )

        # GLB 파일 반환
        return FileResponse(
            path=str(glb_path),
            media_type="model/gltf-binary",
            filename=f"{Path(file.filename).stem}.glb"
        )

    except subprocess.TimeoutExpired:
        logger.error("❌ Timeout expired during conversion")
        raise HTTPException(status_code=408, detail="변환 시간 초과")

    except Exception as e:
        logger.error(f"❌ Unexpected error: {str(e)}")
        import traceback
        logger.error(traceback.format_exc())
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        # 임시 파일 정리
        if skp_path.exists():
            skp_path.unlink()
        # GLB는 FileResponse 후 수동 삭제 필요 (background task 사용 권장)

@app.get("/health")
async def health_check():
    """헬스 체크"""
    return {"status": "ok", "message": "SKP to GLB conversion server is running"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
