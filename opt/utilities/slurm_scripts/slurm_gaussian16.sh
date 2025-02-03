#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=12:00:00
#SBATCH --mem=22GB
#SBATCH --output=/dev/null

input_files="*.com"

#=============================#

module purge

GILLIARDLAB=/home/gridsan/groups/gilliardlab
export g16root=$GILLIARDLAB/opt/chemistry/Gaussian16_A03
export GAUSS_EXEDIR=$g16root/g16
export GAUSS_SCRDIR=$g16root/scr
export PATH="$GILLIARDLAB/opt/chemistry/NBO6/NBO6.i8/bin:$PATH"

if [ -z "$GILLIARDLAB" ]; then
    echo "Error: GILLIARDLAB environment variable is not set."
    exit 1
fi

JOBDIR="$PWD"
export JOBDIR
export PATH=$JOBDIR:$PATH

for file in $input_files; do
    job_name=${file//.com/}
    input_file=${job_name}.com
    output_file=${job_name}.log
    export GAUSSTEMPDIR=$JOBDIR
    mkdir -p "$GAUSSTEMPDIR"/"${job_name}"_tmp
    export TEMPDIR=$GAUSSTEMPDIR/${job_name}_tmp
    cp "$input_file" "$TEMPDIR"
    cd "$TEMPDIR" || exit
    "$GAUSS_EXEDIR"/g16 "$input_file" >& "$output_file" 2>&1
    cp "$TEMPDIR"/"$output_file" "$JOBDIR"/
    cd "$JOBDIR" || exit
done
