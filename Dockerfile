FROM python:3.12-bullseye AS base
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

FROM base as python-base
RUN curl -sSL https://bootstrap.pypa.io/get-pip.py | python3 -
ENV APP_BASE_PATH="/app"
ENV APP_SRC_PATH=${APP_BASE_PATH}/src
ENV PYTHONPATH="${APP_SRC_PATH}:${PYTHONPATH}"
WORKDIR $APP_BASE_PATH

FROM python-base as pip-tools-install
RUN python3 -m pip install pip-tools
WORKDIR ${APP_BASE_PATH}

FROM pip-tools-install as base-python-install
COPY requirements.txt .
RUN pip-sync requirements.txt

FROM base-python-install as dev-python-install
COPY requirements-dev.txt .
RUN pip-sync requirements-dev.txt

FROM base-python-install as service
WORKDIR ${APP_SRC_PATH}
COPY ./src .
ENTRYPOINT ["./start.sh"]

FROM dev-python-install as development
WORKDIR ${APP_SRC_PATH}
ENTRYPOINT ["./start.sh"]