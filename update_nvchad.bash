git remote add NvChad https://github.com/NvChad/NvChad.git
git fetch NvChad
git merge --allow-unrelated-histories --squash NvChad/v2.0
git remote remove NvChad
git commit -m "Update NvChad: $date"
