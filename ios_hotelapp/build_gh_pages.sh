#!/bin/bash

# This script requires you to have installed `ghp-import`, probably using
# pip. (It's a Python package.)
cd server
npm run build
cd ..

cp -r server/build/* gh_pages_build/ios_hotelapp/
ghp-import -n gh_pages_build -m "Update gh-pages"
