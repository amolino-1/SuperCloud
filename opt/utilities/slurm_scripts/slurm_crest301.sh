#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=06:00:00
#SBATCH --mem=66GB
#SBATCH --output=/dev/null

xyz_file="*.xyz"

#=============================#
solvent="CH2Cl2"
level_of_theory="gfn2"
charge=0 # See CREST documentation for more information on specifying multiplicity (--uhf <int>)
#=============================#

module purge

GILLIARDLAB=/home/gridsan/groups/gilliardlab
CREST_PATH=$GILLIARDLAB/opt/chemistry/crest_301

JOBDIR="$PWD"
export JOBDIR
export PATH=$JOBDIR:$PATH

for file in $xyz_file; do

    job_name=${file//.xyz/}
    input_file=${job_name}.xyz
    output_file=${job_name}.out

    export CRESTTEMPDIR=$JOBDIR
    mkdir -p "$CRESTTEMPDIR/${job_name}"_crest_tmp
    export TEMPDIR=$CRESTTEMPDIR/${job_name}_crest_tmp
    cp "$input_file" "$TEMPDIR"
    cd "$TEMPDIR" || exit
    num_threads=$SLURM_NTASKS_PER_NODE
    "$CREST_PATH"/crest "$input_file" --"$level_of_theory" --chrg "$charge" -alpb "$solvent" -T "$num_threads" >& "$output_file" 2>&1
    cp "$TEMPDIR/$output_file" "$JOBDIR"/
    cd "$JOBDIR" || exit
done
