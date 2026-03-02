# 1. Base image thodi navi use karange (Buster di jagah nawa version)
FROM python:3.9-slim

WORKDIR /app
COPY . .

# 2. Saare zaroori tools ikko vaari install karange (Error ton bachan layi desi trick)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    cmake \
    aria2 \
    wget \
    pv \
    jq \
    python3-dev \
    ffmpeg \
    mediainfo \
    && rm -rf /var/lib/apt/lists/*

# 3. Bento4 nu download te install karna
RUN git clone https://github.com/axiomatic-systems/Bento4.git && \
    cd Bento4 && \
    mkdir cmakebuild && \
    cd cmakebuild/ && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make && \
    make install

# 4. Python requirements install karna
RUN pip3 install --no-cache-dir -r requirements.txt

# 5. App nu chalaun layi command
CMD ["sh", "start.sh"]
