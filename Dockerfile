# ==============================================================================
# smoothcomp-scrubber-ui
# Web UI wrapper around smoothcomp-scrubber.
# Builds on top of the scrubber base image.
# Locally: docker build requires local/scrubber to exist first.
# In future: update SCRUBBER_IMAGE to pull from a registry instead.
# ==============================================================================

ARG SCRUBBER_IMAGE=local/scrubber

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
