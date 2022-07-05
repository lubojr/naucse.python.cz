#/bin/bash
#
# This script is executed as the container entry point.
#
export PIPENV_SKIP_LOCK=true
python3 -m pip install pipenv
pipenv install

_start () {
    set -x
    pipenv "$@"
}

if [ -n "$*" ]
then
    _start "$@"
else
    _start run serve --host 0.0.0.0
fi
