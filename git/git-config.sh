#!/bin/bash

git config --global user.name "Jared"
git config --global user.email "jmnoynaert@gmail.com"
git config --global alias.adog "log --all --decorate --oneline --graph"
git config --global alias.dog "log --decorate --oneline --graph"
git config --global alias.history "log --graph --abbrev-commit --decorate --date=relative --all"
git config --global alias.amend "commit --amend"
git config --global alias.tag "tag -a"
git config --global alias.merge "merge --no-ff"
git config --global push.followTags true