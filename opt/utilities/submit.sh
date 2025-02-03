#!/bin/bash

GILLIARDLAB=/home/gridsan/groups/gilliardlab

# Check for the file type present in the directory
if ls -1 *.com &> /dev/null; then
    file_ext="com"
elif ls -1 *.inp &> /dev/null; then
    file_ext="inp"
else
    echo "No .com or .inp files found in the directory."
    exit 1
fi

files=$(ls -1 | grep -c "\.${file_ext}")

if [ ! -f slurm_master ]; then
    echo "WARNING: SLURM master file does not exist - Using 12Hr SLURM template"
    for SLURMJOB in $(seq 1 $files); do
        if [[ "$SLURMJOB" -lt 10 ]]; then
            cp -v $GILLIARDLAB/opt/utilities/slurm_scripts/slurm_orca600.sh slurm_0$SLURMJOB
            sed -i "s/*\.${file_ext}/0${SLURMJOB}*\.${file_ext}/" slurm_0$SLURMJOB
            sbatch slurm_0$SLURMJOB
        else
            cp -v $GILLIARDLAB/opt/utilities/slurm_scripts/slurm_orca600.sh slurm_$SLURMJOB
            sed -i "s/*\.${file_ext}/${SLURMJOB}*\.${file_ext}/" slurm_$SLURMJOB
            sbatch slurm_$SLURMJOB
        fi
    done
else
    for SLURMJOB in $(seq 1 $files); do
        if [[ "$SLURMJOB" -lt 10 ]]; then
            cp -v slurm_master slurm_0$SLURMJOB
            sed -i "s/*\.${file_ext}/0${SLURMJOB}*\.${file_ext}/" slurm_0$SLURMJOB
            sbatch slurm_0$SLURMJOB
        else
            cp -v slurm_master slurm_$SLURMJOB
            sed -i "s/*\.${file_ext}/${SLURMJOB}*\.${file_ext}/" slurm_$SLURMJOB
            sbatch slurm_$SLURMJOB
        fi
    done
fi
