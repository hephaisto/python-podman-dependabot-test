FROM docker.io/library/python:latest
ARG build_container
COPY ./requirements.txt /requirements.txt
COPY --from=${build_container} /out/*.whl /wheels/
RUN python -m pip install --no-deps -r /requirements.txt
RUN python -m pip install --no-deps /wheels/*.whl
ENTRYPOINT run-web-ui
