#!/bin/bash
set -e
set -x
scriptdir=$(cd $(dirname $0) && pwd)

mkdir -p ./tmp/lockfiles
podman run \
	--mount type=bind,src=./tmp/lockfiles,target=/lockfiles \
	--mount type=bind,src=.,target=/src,ro \
	docker.io/library/python:latest bash -c "python -m pip install uv && uv pip compile /src/pyproject.toml -o /lockfiles/dependencies.lock && uv pip compile --extra test /src/pyproject.toml -o /lockfiles/dependencies-test.lock"
mv ./tmp/lockfiles/dependencies.lock ${scriptdir}/requirements.txt
mv ./tmp/lockfiles/dependencies-test.lock ${scriptdir}/tests/requirements.txt
