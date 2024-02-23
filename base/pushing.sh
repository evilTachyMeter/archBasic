#!/bin/bash

DEFAULT_PUSH_COMMENT="meat "

git add --all
git commit -m "${*:-$DEFAULT_PUSH_COMMENT}"
git push

