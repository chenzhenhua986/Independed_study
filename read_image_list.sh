src=/scratch/chen478/UCF/UCF_diff_test
des=/nobackup/chen478/UCF

for i in $src/*;do
  IFS='_' read -r -a array <<< "$i"
  echo ${array[-1]}
  for j in $i/*; do
    for k in $j/*; do
      for l in $k/*; do
        for m in $l/*; do
          echo $m ${array[-1]} >> $des/train.txt
        done
      done
    done
  done
done
#      echo $(echo $k| cut -d'/' -f 8) 0  >> $j/train.txt

