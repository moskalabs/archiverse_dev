FROM ubuntu:22.04

# 비대화형 모드 설정
ENV DEBIAN_FRONTEND=noninteractive

# 시스템 패키지 업데이트 및 필수 도구 설치 (assimp 포함)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    wget \
    unzip \
    xz-utils \
    libxrender1 \
    libxi6 \
    libxkbcommon0 \
    libsm6 \
    libgl1 \
    libassimp-dev \
    assimp-utils \
    && rm -rf /var/lib/apt/lists/*

# Blender 4.2 LTS 다운로드 및 설치
RUN wget https://download.blender.org/release/Blender4.2/blender-4.2.0-linux-x64.tar.xz -O /tmp/blender.tar.xz && \
    tar -xf /tmp/blender.tar.xz -C /opt && \
    ln -s /opt/blender-4.2.0-linux-x64/blender /usr/local/bin/blender && \
    rm /tmp/blender.tar.xz

# 작업 디렉토리 설정
WORKDIR /app

# Python 의존성 복사 및 설치
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# 애플리케이션 파일 복사
COPY main.py .
COPY convert_skp_to_glb.py .

# temp 디렉토리 생성
RUN mkdir -p /app/temp

# 포트 노출
EXPOSE 8000

# 서버 실행
CMD ["python3", "main.py"]
