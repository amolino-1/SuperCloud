#!/bin/bash

time=$1

fd . --extension out --type file --color always --changed-within ${time} --base-directory /home/gridsan/$USER --exclude '*_tmp'

# fd . --extension log --type file --color always --changed-within ${time} --base-directory /home/gridsan/$USER --exclude '*_tmp'

