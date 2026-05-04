#!/bin/bash
set -e
set -x
scriptdir=$(cd $(dirname $0) && pwd)
project_name=$(basename "$scriptdir")
podman run -it --mount type=bind,src=${scriptdir}/tests,target=/tests ${project_name}:local-test --browser chromium /tests
