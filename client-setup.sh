#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

cd Back-End

echo "${BLUE}Seeding database...${NC}"

npm run seed
npm run relations

echo "${GREEN}Done!${NC}"

cd ../Front-End

echo "${BLUE}Installing Front-End dependencies${NC}"

npm i

echo "${GREEN}Done!${NC}"

npm start