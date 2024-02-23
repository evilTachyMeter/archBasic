#!/bin/bash

DEFAULT_PUSH_COMMENT="rice balls"

git add --all
git commit -m "${*:-$DEFAULT_PUSH_COMMENT}"
git push

