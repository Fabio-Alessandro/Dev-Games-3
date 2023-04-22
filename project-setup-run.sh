#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

createdb devgames3

cd Back-End

echo "${BLUE}Creating Back-End environment variables...${NC}"

read -p "Enter your PostgreSQL username (press enter if null): " DB_USER
read -p "Enter your PostgreSQL password (press enter if null): " DB_PASSWORD

echo "PORT=3001" > ./.env

if [ -z "$DB_USER" ]
then
  echo "DB_USER=null" >> ./.env
else
  echo "DB_USER=\"$DB_USER\"" >> ./.env
fi

if [ -z "$DB_PASSWORD" ]
then
  echo "DB_PASSWORD=null" >> ./.env
else
  echo "DB_PASSWORD=\"$DB_PASSWORD\"" >> ./.env
fi

echo "DB_NAME=devgames3" >> ./.env
echo "CORS_ORIGIN=\"http://localhost:3000\"" >> ./.env
echo "DB_HOST=localhost" >> ./.env
echo "DB_DIALECT=postgres" >> ./.env
echo "JWT_SECRET=secret" >> ./.env
echo "${GREEN}Done!${NC}"
echo "${BLUE}Installing Back-End dependencies${NC}"

npm i

echo "${GREEN}Done!${NC}"

cd ../Front-End

echo "${BLUE}Installing Front-End dependencies${NC}"

npm i

echo "${GREEN}Done!${NC}"

cd ../Back-End

echo "${BLUE}Starting Back-End server...${NC}"

npm start &

while ! nc -z localhost 3001; do
  sleep 1
done

echo "${GREEN}Back-End server started!${NC}"

echo "${BLUE}Seeding database...${NC}"

npm run seed
npm run relations

echo "${GREEN}Done!${NC}"

cd ../Front-End

echo "${BLUE}Starting Front-End server...${NC}"

npm start