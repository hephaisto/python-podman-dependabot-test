FROM docker.io/library/debian:13.4
ARG build_container
ENV SOURCE_DATE_EPOCH=1700000000

RUN apt-get update && apt-get install -y python3-venv
RUN python3 -m venv /opt/env

COPY ./tests/requirements.txt /requirements.txt
RUN /opt/env/bin/python -m pip install --no-deps -r /requirements.txt
RUN /opt/env/bin/python -m playwright install-deps chromium
RUN /opt/env/bin/python -m playwright install chromium

COPY --from=${build_container} /out/*.whl /wheels/
RUN /opt/env/bin/python -m pip install --no-deps /wheels/*.whl


ENTRYPOINT ["/opt/env/bin/pytest"]
