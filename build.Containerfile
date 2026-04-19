FROM docker.io/library/python:latest
COPY . /src
RUN python -m pip install build
RUN python -m pip install --no-deps -r /src/requirements.txt
RUN python -m build --skip-dependency-check --outdir /out /src
