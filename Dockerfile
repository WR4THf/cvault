FROM ubuntu:26.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    clang \
    git \
    qt6-base-dev \
    qt6-declarative-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR	/build

COPY . .

RUN rm -rf build && cmake -B build -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build --config Release


FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libqt6gui6 \
    libqt6qml6 \
    libqt6quick6 \
    qml6-module-qtquick-controls \
    libgl1-mesa-dri \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /build/build/cvault .

CMD ["./cvault"]
