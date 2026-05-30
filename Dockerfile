# ==============================================================================
# smoothcomp-scrubber-ui
# Web UI wrapper around smoothcomp-scrubber.
# Builds on top of the smoothcomp-scrubber base image from Docker Hub
# ==============================================================================

ARG SCRUBBER_IMAGE=deloachcd/smoothcomp-scrubber:may-2026
FROM ${SCRUBBER_IMAGE}

ARG DEBIAN_FRONTEND=noninteractive

# Install web dependencies into the existing pipenv
RUN pipenv install fastapi "uvicorn[standard]"

# Copy the web app
COPY app /app

RUN mkdir -p /videos /outputs /config
VOLUME ["/videos", "/outputs", "/config"]

ENV VIDEOS_DIR=/videos
ENV OUTPUTS_DIR=/outputs
ENV CONFIG_DIR=/config

EXPOSE 8080

CMD ["pipenv", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
