FROM ubuntu:22.04

# 비대화형 모드 설정
ENV DEBIAN_FRONTEND=noninteractive

# 시스템 패키지 업데이트 및 필수 도구 설치
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    blender \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /app

# Python 의존성 복사 및 설치
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# 애플리케이션 파일 복사
COPY main.py .
COPY convert_skp_to_glb.py .

# SketchUp Importer 애드온 다운로드 및 설치
RUN mkdir -p /root/.config/blender/4.0/scripts/addons && \
    wget https://github.com/RedHaloStudio/Sketchup_Importer/archive/refs/heads/main.zip -O /tmp/skp_importer.zip && \
    unzip /tmp/skp_importer.zip -d /tmp && \
    cp -r /tmp/Sketchup_Importer-main/sketchup_importer /root/.config/blender/4.0/scripts/addons/ && \
    rm -rf /tmp/skp_importer.zip /tmp/Sketchup_Importer-main

# Blender 애드온 활성화 스크립트
RUN echo "import bpy; bpy.ops.preferences.addon_enable(module='sketchup_importer'); bpy.ops.wm.save_userpref()" > /tmp/enable_addon.py && \
    blender -b --python /tmp/enable_addon.py && \
    rm /tmp/enable_addon.py

# temp 디렉토리 생성
RUN mkdir -p /app/temp

# 포트 노출
EXPOSE 8000

# 서버 실행
CMD ["python3", "main.py"]
