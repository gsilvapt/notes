#! /usr/bin/env bash

timestamp=$(date '+%Y-%m-%d %H:%M')
zet_cnt=$(expr $(find ../docs/notes/* -maxdepth 1 -type d | wc -l) + 1)
filepath="../docs/notes/$zet_cnt/"
mkdir "$filepath"
 
echo -e "---\ndate: $timestamp\n---" > "$filepath/index.md"
echo -e "* $timestamp: [$zet_cnt]($zet_cnt/index.md)" | cat - ../docs/notes/index.md > temp && mv temp ../docs/notes/index.md
