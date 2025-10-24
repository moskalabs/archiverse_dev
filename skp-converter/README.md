# SKP to GLB Conversion Server

FastAPI 기반 SketchUp(.skp) 파일을 glTF Binary(.glb) 형식으로 변환하는 서버입니다.

## 요구사항

- Python 3.8+
- Blender 3.0+ (시스템에 설치되어 있어야 함)

## 설치

1. Python 패키지 설치:
```bash
pip install -r requirements.txt
```

2. Blender 설치:
```bash
# Ubuntu/Debian
sudo apt-get install blender

# macOS
brew install blender

# Windows
# https://www.blender.org/download/ 에서 다운로드
```

## 실행

```bash
python main.py
```

서버는 `http://localhost:8000` 에서 실행됩니다.

## API 사용법

### SKP를 GLB로 변환

**POST** `/convert-skp-to-glb`

**요청:**
- Content-Type: `multipart/form-data`
- Body: `file` (SKP 파일)

**응답:**
- GLB 파일 (binary)

**예시:**
```bash
curl -X POST "http://localhost:8000/convert-skp-to-glb" \
  -F "file=@model.skp" \
  -o output.glb
```

### 헬스 체크

**GET** `/health`

**응답:**
```json
{
  "status": "ok",
  "message": "SKP to GLB conversion server is running"
}
```

## 주의사항

현재 Blender의 SKP import는 추가 애드온이 필요합니다.
대안으로 SketchUp에서 Collada(.dae) 형식으로 export 한 후 사용하세요.

## Docker 배포 (예정)

```bash
docker build -t skp-converter .
docker run -p 8000:8000 skp-converter
```
