#!/bin/bash

###############################
###       User Input        ###
###############################
logfile='<basename>.log'

# Path to BCW python script
GILLIARDLAB=/home/gridsan/groups/gilliardlab
BCWPATH=$GILLIARDLAB/opt/chemistry/bcwizard-main/bcw.py

module purge
module load anaconda

# Strip the suffix from <basename>.out and assign it to variable 'filename'
filename=${logfile//.log/}

cat << EOF > CurrentDens.in
1
5
${logfile}



8
opt
-27


-1
3
1

-1
5
1
${filename}_current
5
6
-1
6
8
png
0
EOF

python $BCWPATH < CurrentDens.in | tee CurrentDens.out  #Run command
rm ./CurrentDens.in
