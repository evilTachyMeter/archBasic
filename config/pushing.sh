#!/bin/bash

DEFAULT_PUSH_COMMENT="push from script file"

git add --all
git commit -m "${*:-$DEFAULT_PUSH_COMMENT}"
git push

