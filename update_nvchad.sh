#!/bin/bash

git remote add NvChad https://github.com/NvChad/NvChad.git
git fetch NvChad
git merge --allow-unrelated-histories --squash NvChad/v2.5
git remote remove NvChad
git checkout --ours .gitignore
git add .gitignore
git rm -r .github/
git commit -m "update(NvChad): $(date +'%Y-%m-%d %H:%M:%S')"
