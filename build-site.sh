#!/bin/bash

COMPOSE_FILE="compose-build-site.yaml"

docker compose -f "$COMPOSE_FILE" up
docker compose -f "$COMPOSE_FILE" down
