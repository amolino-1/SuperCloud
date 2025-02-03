#!/bin/bash

if [ -n "$1" ]; then
    USER=$1
fi

numbers=( $(squeue -u "$USER" | tail -n +2 | sort | awk '{print $1}') )
cputimes=( $(squeue -u "$USER" | tail -n +2 | sort | awk '{print $6}') )
jobstatus=( $(squeue -u "$USER" | tail -n +2 | sort | awk '{print $5}') )

echo ${#numbers[*]} jobs for "$USER"

for (( i = 0 ; i < ${#numbers[@]} ; i++ )); do
    directory="$(scontrol show jobid -dd "${numbers[$i]}" | grep WorkDir | sed 's%WorkDir=%%g')"
    printf "%s %s %s %s\n" "${jobstatus[$i]}" "${cputimes[$i]}" "${numbers[$i]}" | awk '{printf "%-4s%-12s%-4s", $1, $2, $3}'
    printf "%s\n" " $directory"
done
