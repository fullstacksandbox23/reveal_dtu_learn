#!/bin/bash

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)
cd $REPO_ROOT_DIR
docker compose build svelte-revealjs
docker compose up svelte-revealjs -d
docker compose exec svelte-revealjs sh -c "/bin/sh"
docker compose down