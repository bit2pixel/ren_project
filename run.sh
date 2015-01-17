#!/bin/bash

# Usage:
# ./run [port]
# ./run 8080
PORT=$1

if [ -z "$PORT" ]; then
    echo "You need to specify a port number"
    echo "Example: ./run.sh 8080"
    exit 1
fi

if [ -z "$VIRTUAL_ENV" ]; then
    echo "Loading virtual environment"
    source ren_project_venv/bin/activate
fi

# Update assets
./manage.py collectstatic --noinput

# Run uwsgi
./ren_project_venv/bin/uwsgi --socket 127.0.0.1:$PORT --ini ren_project/wsgi.ini
