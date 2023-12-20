#!/bin/bash

npm i
npm run build
npm i -g serve
serve -s dist -p 5173