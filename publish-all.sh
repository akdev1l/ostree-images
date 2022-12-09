#!/bin/bash

find images -maxdepth 1 -mindepth 1 -type d | xargs -n1 basename | while read image_tag; do
    ./util/publish.sh "${image_tag}"
done


