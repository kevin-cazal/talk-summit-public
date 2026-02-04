#!/bin/bash
cd demos/wasmboy_demos
npm run serve:all &
cd ../../presentation
python3 -m http.server 9000 &
firefox http://localhost:9000
