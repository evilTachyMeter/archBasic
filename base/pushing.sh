#!/bin/bash

DEFAULT_PUSH_COMMENT="meat "

git add ./
git commit -m "${*:-$DEFAULT_PUSH_COMMENT}"
git push

