#!/bin/bash

DEFAULT_PUSH_COMMENT="chinese mealboxes"

git add --all
git commit -m "${*:-$DEFAULT_PUSH_COMMENT}"
git push

