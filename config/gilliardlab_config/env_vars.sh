#!/bin/bash

GILLIARDLAB=/home/gridsan/groups/gilliardlab

# Color settings for file extensions
export LS_COLORS="$LS_COLORS"\
':*.inp=0;33'\
':*.com=0;33'\
':*.out=0;31'\
':*.gbw=1;32'\
':*.run=0;33'\
':*.log=0;31'\
':*.xyz=0;35'\
':*trj.xyz=0;0'\
':*scfgrad.inp=0;0'\
':*.res.*=0;36'
export CLICOLOR=1

[[ ":$PATH:" != *":$GILLIARDLAB/.local/bin:"* ]] && export PATH="$PATH:$GILLIARDLAB/.local/bin"

### ORCA 6.0.1
export ORCA_PATH=$GILLIARDLAB/opt/chemistry/Orca_601_avx2
[[ ":$PATH:" != *":$ORCA_PATH:"* ]] && export PATH="$PATH:$ORCA_PATH"
[[ ":$LD_LIBRARY_PATH:" != *":$ORCA_PATH:"* ]] && export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$ORCA_PATH"

### ORCA 6.0.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GILLIARDLAB/opt/chemistry/Orca_600_avx2

### ORCA 5.0.4
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GILLIARDLAB/opt/chemistry/Orca_504

### Gaussian16
export g16root=$GILLIARDLAB/opt/chemistry/Gaussian16_A03
export GAUSS_EXEDIR=$g16root/g16
export GAUSS_SCRDIR=$g16root/scr
export PATH=$PATH:$GAUSS_EXEDIR

### Crest 3.0.1
export PATH=$PATH:$GILLIARDLAB/opt/chemistry/crest_301

### GIMIC
export PATH=$PATH:/home/gridsan/groups/gilliardlab/opt/chemistry/gimic_221/build/

### NBO6
export NBOBIN=$GILLIARDLAB/opt/chemistry/NBO6/NBO6.i8/bin
export NBOEXE=$GILLIARDLAB/opt/chemistry/NBO6/NBO6.i8/bin/nbo6.i8.exe

### Multiwfn 3.8
# export Multiwfnpath=$GILLIARDLAB/opt/chemistry/Multiwfn_3.8
# export PATH=$PATH:$GILLIARDLAB/opt/chemistry/Multiwfn_3.8
# export OMP_STACKSIZE=200M
# ulimit -s unlimited

### R
export PATH=$PATH:$GILLIARDLAB/opt/utilities/R/R-4.4.1/bin

### Sysmoic
export PATH=$PATH:$GILLIARDLAB/opt/chemistry/Sysmoic/STABIN/
