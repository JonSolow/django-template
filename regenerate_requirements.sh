
#!/bin/bash

set -ex

ADDITIONAL_ARGS=$@

pip-compile \
    -o requirements.txt \
    $ADDITIONAL_ARGS \
    pyproject.toml
    
pip-compile \
    --extra=dev \
    -o requirements-dev.txt \
    $ADDITIONAL_ARGS \
    pyproject.toml
