#!/bin/bash


set -f                      # avoid globing (expansion of *).
array=(${1//-/ })     
for i in "${!array[@]}"
do
    echo "$i=>${array[i]}"
done
                            # need to work on items in list
