#!/bin/bash

###############################
###       User Input        ###
###############################
xyzfile='<basename>.xyz'
chargemultiplicity='0 1'

# Path to BCW python script
GILLIARDLAB=/home/gridsan/groups/gilliardlab
BCWPATH=$GILLIARDLAB/opt/chemistry/bcwizard-main/bcw.py

module purge
module load anaconda

# Strip the suffix from <basename>.out and assign it to variable 'filename'
filename=${xyzfile//.xyz/}

cat << EOF > NICS_Calc.in
1
1
${xyzfile}
7
1.25
-1
5
1
${filename}
7
${chargemultiplicity}
0
EOF

python $BCWPATH < NICS_Calc.in | tee NICS_Calc.out  #Run command
rm ./NICS_Calc.in
