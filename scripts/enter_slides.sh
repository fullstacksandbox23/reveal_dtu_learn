#!/bin/bash

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)
cd $REPO_ROOT_DIR
docker compose -f compose.yml -f compose.prod.yml build slides
docker compose -f compose.yml -f compose.prod.yml up slides -d
docker compose -f compose.yml -f compose.prod.yml exec slides sh -c "/bin/sh"
docker compose -f compose.yml -f compose.prod.yml down