#!/bin/bash

GILLIARDLAB=/home/gridsan/groups/gilliardlab

# Group Aliases
alias stream='less -S +F'
alias jobstat='$GILLIARDLAB/opt/utilities/jobstat.sh'
alias submit='$GILLIARDLAB/opt/utilities/submit.sh'
alias fdd='$GILLIARDLAB/opt/utilities/fdd.sh'

rename() {
│   local from=$1
│   local to=$2
│   shift 2
│   local files="$@"
│
│   for file in $files; do
│   │   $GILLIARDLAB/opt/utilities/rename.pl "s/$from/$to/" "$file"
│   done
}

### ORCA
alias conv='egrep --color "YES|      NO|GEOMETRY OPTIMIZATION CYCLE|HURRAY|THE OPTIMIZATION HAS CONVERGED|ORCA TERMINATED NORMALLY|ORCA finihed with error|Optimization Cycle: |N\(occ\)="'
alias orcainfo='$GILLIARDLAB/opt/utilities/orcainfo.sh -o'
alias ofakeg='$GILLIARDLAB/opt/utilities/OfakeG_V1.1.sh'

### ORCA 5.0.4
alias copy5orca='cp $GILLIARDLAB/opt/utilities/slurm_scripts/slurm_orca504.sh'
alias orca5_2mkl='$GILLIARDLAB/opt/chemistry/Orca_504/orca_2mkl'
### ORCA 6.0.0
alias copy600orca='cp $GILLIARDLAB/opt/utilities/slurm_scripts/slurm_orca600.sh'
alias orca600_2mkl='$GILLIARDLAB/opt/chemistry/Orca_600_avx2/orca_2mkl'
### ORCA 6.0.1
alias copyorca='cp $GILLIARDLAB/opt/utilities/slurm_scripts/slurm_orca601.sh'
alias orca601_2mkl='$GILLIARDLAB/opt/chemistry/Orca_601_avx2/orca_2mkl'

### Gaussian 16
alias copyg16='cp $GILLIARDLAB/opt/utilities/slurm_scripts/slurm_gaussian16.sh'
alias gview='$GILLIARDLAB/opt/chemistry/gaussview6/gview.exe &'

### Crest 3.0.1
alias copycrest='cp $GILLIARDLAB/opt/utilities/slurm_scripts/slurm_crest301.sh'

### GIMIC 2.2.1
alias copygimic='cp $GILLIARDLAB/opt/utilities/slurm_scripts/slurm_gimic221.sh'

### Multiwfn 3.8
alias multiwfn='$GILLIARDLAB/opt/chemistry/Multiwfn_3.8/Multiwfn_noGUI'

### EDDB
alias runeddb='OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 MKL_NUM_THREADS=1 Rscript --vanilla $GILLIARDLAB/opt/chemistry/EDDB/RunEDDB.R'

### BCW
alias bcw='python $GILLIARDLAB/opt/chemistry/bcwizard-main/bcw.py'
alias copybcw='cp $GILLIARDLAB/opt/utilities/bcw_scripts/step1_bcw_nics.sh . && cp $GILLIARDLAB/opt/utilities/bcw_scripts/step2_bcw_currentdens.sh .'
