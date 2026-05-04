FROM docker.io/library/python:latest
ENV SOURCE_DATE_EPOCH=1700000000
RUN python -m pip install build
COPY ./requirements.txt /requirements.txt
RUN python -m pip install --no-deps -r /requirements.txt
COPY . /src
RUN python -m build --skip-dependency-check --outdir /out /src
