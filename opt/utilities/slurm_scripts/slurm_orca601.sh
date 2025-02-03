#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=12:00:00
#SBATCH --mem=66GB
#SBATCH --output=/dev/null

input_files="*.inp"

#=============================#

module purge
module load mpi/openmpi-4.1.5

GILLIARDLAB=/home/gridsan/groups/gilliardlab
ORCA_PATH=$GILLIARDLAB/opt/chemistry/Orca_601_avx2
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GILLIARDLAB/opt/chemistry/Orca_601_avx2
NBOEXE=$GILLIARDLAB/opt/chemistry/NBO6/NBO6.i8/bin/nbo6.i8.exe

if [ -z "$GILLIARDLAB" ]; then
    echo "Error: GILLIARDLAB environment variable is not set."
    exit 1
fi

JOBDIR="$PWD"
export JOBDIR
export PATH=$JOBDIR:$PATH

for file in $input_files; do
    job_name=${file//.inp/}
    input_file=${job_name}.inp
    output_file=${job_name}.out
    export ORCATEMPDIR=$JOBDIR
    mkdir -p "$ORCATEMPDIR/${job_name}"_tmp
    export TEMPDIR=$ORCATEMPDIR/${job_name}_tmp
    cp "$input_file" "$TEMPDIR"
    dependencies=$(find "$JOBDIR" -type d -iname "dependencies" -print -quit)
    if [ -n "$dependencies" ]; then
        dependency_errors=$(find "$dependencies" -type f -not -name "${job_name}_D?????.res.*")
        if [ -n "$dependency_errors" ]; then
            echo "Error: Input filename '$input_file' does not match dependency file name(s):"
            exit 1
        else
            find "$dependencies" -type f -name "${job_name}_D?????.res.*" -exec cp {} "$TEMPDIR" \;
        fi
    fi
    cd "$TEMPDIR" || exit
    "$ORCA_PATH"/orca "$input_file" >& "$output_file" 2>&1
    cp "$TEMPDIR/$output_file" "$JOBDIR"/
    cd "$JOBDIR" || exit
done
