FROM python:3.8-alpine
WORKDIR /code
ENV PYTHONBUFFERED=1
COPY Pipfile* /code/
COPY docker-entrypoint.sh /code
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install --no-install-recommends build-essential -y \
    && export PIP_NO_CAHCE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1 \
    && pip install pipenv \
    && pipenv install --system --deploy \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
EXPOSE 5000/tcp
RUN export PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1 \
    && pipenv install --system --deploy --dev
ENTRYPOINT [ "/code/docker-entrypoint.sh" ]