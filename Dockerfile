FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# 使用清华大学的apt源
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn\/ubuntu/g' /etc/apt/sources.list

RUN apt-get update

RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    build-essential \
    cmake \
    ffmpeg \
    git \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    python3-tk \
    curl \
    libcufft10 --fix-missing && \
    rm -rf /var/lib/apt/lists/*


RUN \
    apt-get update \
    && apt-get install -qy \
    build-essential \
    curl \
    ffmpeg \
    gcc \
    git \    
    libffi-dev \ 
    locales \ 
    musl-dev --fix-missing \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \    
    && ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime \
    && echo "Europe/Berlin" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TZ=Europe/Berlin

ENV PYTHONDONTWRITEBYTECODE=0  
ENV PYTHONUNBUFFERED=0      

RUN \
    git clone --depth=1 https://github.com/hacksider/Deep-Live-Cam . 

RUN \
    curl -SL -o /app/models/GFPGANv1.4.pth 'https://huggingface.co/hacksider/deep-live-cam/resolve/main/GFPGANv1.4.pth' \
    && curl -SL -o /app/models/inswapper_128_fp16.onnx 'https://huggingface.co/hacksider/deep-live-cam/resolve/main/inswapper_128_fp16.onnx'

RUN pip install --upgrade pip && pip install -r requirements.txt

RUN groupadd -r deepgroup \
    && useradd --no-log-init -r -g deepgroup deepuser \
    && chown -R deepuser:deepgroup /app

USER deepuser

CMD ["python", "run.py"]