#!/bin/bash

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)
cd $REPO_ROOT_DIR
docker compose -f compose.yml -f compose.prod.yml build revealjs
docker compose -f compose.yml -f compose.prod.yml up revealjs -d
docker compose -f compose.yml -f compose.prod.yml exec revealjs sh -c "/bin/sh"
docker compose -f compose.yml -f compose.prod.yml down