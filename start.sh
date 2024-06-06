#!/bin/bash

set -e

nc='\033[0m'
r='\033[0;31m'
g='\033[0;32m'

LANGS=(
  "en"
  "cn"
)

while [[ "$1" =~ ^"-" ]]; do
  if [ "$1" = "-l" ]; then
    shift 1; lang=$1
  fi
  shift 1
done

[ -z "$1" ] && action="serve" || action=$1

if [ -z "$lang" ]; then
  lang="en"
elif [[ ! ${LANGS[*]} =~ $lang ]]; then
  echo -e "\n  ERROR: Undefined lang: ${r}$lang${nc}\n" && exit 1
fi
echo -e "\n  ACTION: ${g}$action${nc}, LANG: ${g}$lang${nc}\n"

# Provide extra options for jekyll when needed.
[ "$lang" != "en" ] && jekyll_cmd_extra_options="--config _config.yml,$lang/_config.yml"

# Docker compose
if [ "$action" == "build" ]; then
  COMPOSE_FILE="compose-build-site.yaml"

  JEKYLL_CMD_EXTRA_OPTIONS="$jekyll_cmd_extra_options" docker compose -f "$COMPOSE_FILE" up
  docker compose -f "$COMPOSE_FILE" down
else
  JEKYLL_CMD_EXTRA_OPTIONS="$jekyll_cmd_extra_options" docker compose up
fi
