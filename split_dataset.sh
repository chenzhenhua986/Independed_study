#!/bin/bash
ROOT=/nobackup/chen478/UCF/
DES_TRAIN=/nobackup/chen478/UCF_Train/
DES_TEST=/nobackup/chen478/UCF_Test/
f_train=/nobackup/chen478/ucfTrainTestlist/trainlist01.txt
f_test=/nobackup/chen478/ucfTrainTestlist/testlist01.txt
while IFS=' ' read -r col1 col2
do  
    IFS='/' read -r -a array <<< "$col1"
    if [ ! -d "${DES_TRAIN}${array[0]}" ]; then
        mkdir ${DES_TRAIN}${array[0]}
    fi
    cp ${ROOT}${col1} ${DES_TRAIN}${array[0]} 
done <$f_train

while read -r col1
do  
    IFS='/' read -r -a array <<< "$col1"
    if [ ! -d "${DES_TEST}${array[0]}" ]; then
        mkdir ${DES_TEST}${array[0]}
    fi
    src=${ROOT}${col1}
    cp ${src%?}  ${DES_TEST}${array[0]} 
done <$f_test





