FROM jasongardner/dxc:latest AS compilers
ADD https://github.com/veka0/bgfx-mcbe/releases/download/binaries/shaderc-linux-x64.zip /tmp/shaderc.zip

RUN apt-get update && \
    apt-get install -y unzip && \
    unzip /tmp/shaderc.zip -d /opt/ && \
    rm /tmp/shaderc.zip && \
    mkdir -p /opt/shaderc/bin && \
    mv /opt/shadercRelease /opt/shaderc/bin/shaderc && \
    chmod +x /opt/shaderc/bin/*
FROM python:3.12-slim AS base

COPY --from=compilers /opt/dxc /opt/dxc
ENV PATH="/opt/dxc/bin:$PATH"

COPY --from=compilers /opt/shaderc /opt/shaderc
ENV PATH="/opt/shaderc/bin:$PATH"

RUN pip install lazurite[opengl]

CMD ["bash"]