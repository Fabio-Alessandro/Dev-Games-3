#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

cd Back-End

echo "${BLUE}Starting Back-End server...${NC}"

npm start &

while ! nc -z localhost 3001; do
  sleep 1
done

echo "${GREEN}Back-End server started!${NC}"

cd ../Front-End

echo "${BLUE}Starting Front-End server...${NC}"

npm start