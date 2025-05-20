FROM jasongardner/dxc:latest AS dxc
FROM python:3.11-slim AS base

COPY --from=dxc /opt/dxc /opt/dxc
ENV PATH="/opt/dxc/bin:$PATH"

RUN apt update -y && apt install glslang

RUN pip install lazurite[opengl]
