#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=12:00:00
#SBATCH --mem=22GB
#SBATCH --output=/dev/null

input_files="*.inp"

#=============================#

module purge

GILLIARDLAB=/home/gridsan/groups/gilliardlab
gimicroot=$GILLIARDLAB/opt/chemistry/gimic_221

JOBDIR="$PWD"
export JOBDIR
export PATH=$JOBDIR:$PATH

for file in $input_files; do
    job_name=${file//.com/}
    input_file=${job_name}.inp
    output_file=${job_name}.out
    export GIMICTEMPDIR=$JOBDIR
    mkdir -p "$GIMICTEMPDIR"/"${job_name}"_tmp
   export TEMPDIR=$GIMICTEMPDIR/${job_name}_tmp
   cp "$input_file" "$TEMPDIR"
   cd "$TEMPDIR" || exit
   "$gimicroot"/build/bin/gimic "$input_file" >& "$output_file" 2>&1
   cp "$TEMPDIR"/"$output_file" "$JOBDIR"/
   cd "$JOBDIR" || exit
done
