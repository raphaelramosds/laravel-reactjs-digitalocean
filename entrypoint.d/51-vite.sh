#!/bin/sh

if [ "$APP_ENV" = "local" ]; then
    npm run dev &
else
    npm run build
fi