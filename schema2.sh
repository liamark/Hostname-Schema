#!/bin/bash

string="1:2:3:4:5"
set -f                      # avoid globbing (expansion of *).
array=(${string//:/ })
for i in "${!array[@]}"
do
    echo "$i=>${array[i]}"
done
