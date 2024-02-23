#!/bin/bash

DEFAULT_PUSH_COMMENT="rice balls"

git add ./
git commit -m "${*:-$DEFAULT_PUSH_COMMENT}"
git push

