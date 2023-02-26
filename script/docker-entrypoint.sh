#!/usr/bin/env bash
NAME="Schedule-excel-parser" # Name of the application
# shellcheck disable=SC2034
DJANGO_DIR=/app # Django project directory
USER=root       # the user to run as
# shellcheck disable=SC2034
GROUP=root # the group to run as
# shellcheck disable=SC2034
DJANGO-WSGI-MODULE=app.asgi

echo "Starting $NAME as $(whoami)"

# Activate the virtual environment
# shellcheck disable=SC2164
cd $DJANGO_DIR

python manage.py makemigrations &&
  python manage.py migrate && \

# Start your Django Hypercorn
exec hypercorn app.asgi:application \
  --bind 0.0.0.0:8000
