#!/bin/bash

npm i 
npm i --save @nestjs/config # for using env variables in ft.strategy.ts
npm i @nestjs/passport passport passport-42 dotenv # for 42 OAuth2.0
npm run prisma
npm run start