#!/bin/bash

#files=$(ls -1 | grep -xc "pbs_[0-9][0-9]")

for SLURMJOB in $(seq 1 50); do
    if [[ "$SLURMJOB" -lt 10 ]]; then
        TEMPFOLDER=0${SLURMJOB}*_tmp
        if [ -d $TEMPFOLDER ]; then
            mv slurm_0"${SLURMJOB}"* 0"${SLURMJOB}"*_tmp 2>/dev/null
        else
            :
        fi
    else
        TEMPFOLDER=${SLURMJOB}*_tmp
        if [ -d $TEMPFOLDER ]; then
            mv slurm_"${SLURMJOB}"* "${SLURMJOB}"*_tmp 2>/dev/null
        else
            :
        fi
    fi
done
