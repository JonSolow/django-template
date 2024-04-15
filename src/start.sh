#!/bin/bash

# sleep command to replace
# /bin/sh -c "while sleep 1000; do :; done"

# change to actual project name when replacing demo
DJANGO_APP_NAME=demo

python $APP_SRC_PATH/$DJANGO_APP_NAME/manage.py runserver
