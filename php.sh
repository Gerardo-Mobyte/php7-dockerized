#!/bin/sh

docker run --rm -it php:7-alpine "$@"
return $?
