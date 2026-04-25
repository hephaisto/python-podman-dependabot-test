FROM docker.io/library/python:latest
ARG build_container

# This installs the application first, dependencies second
# This is suitable if the dependencies are updated more often than the
# application, i.e. for slow-pace projects. If you update the application
# more often than you get updates from dependencies, revert the order of the
# two following blocks

COPY --from=${build_container} /out/*.whl /wheels/
RUN python -m pip install --no-deps /wheels/*.whl

COPY ./requirements.txt /requirements.txt
RUN python -m pip install --no-deps -r /requirements.txt

ENTRYPOINT ["run-web-ui"]
