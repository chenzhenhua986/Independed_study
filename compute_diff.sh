#!/bin/bash

SRC=/scratch/chen478/UCF/UCF_clipped_test
DES=/scratch/chen478/UCF/UCF_diff_test
diff_num=5
TXT_PATH=/nobackup/chen478

for i in $SRC/*;do
  IFS='_' read -r -a category <<< "$i"
  for j in $i/*;do # video
    for k in $j/*;do # crop
      for l in $k/*;do # clip
        IFS='/' read -r -a array <<< "$l"
        name=${array[-4]}_${array[-3]}_${array[-2]}_${array[-1]}
        if [ ! -d $dir ]; then
          mkdir -p $dir
        fi
        nu=$(ls $l/  | wc -l)
        echo "number of frames: " $nu
        echo "source: " $l
        echo "destination: " $DES/${array[-4]}/${array[-3]}/${array[-2]}/${array[-1]}
        cd $l
        if [ $nu -gt $diff_num ]; then
            for im in $(eval echo {1..$diff_num}); do
              echo $((im+1)) $im
              compare $((im+1)).png ${im}.png ${DES}/${name}_${im}.png
              echo ${name}_${im}.png ${category[-1]}  >> $TXT_PATH/train.txt 
            done 
        else
	    for im in $(eval echo {1..$diff_num}); do
              r=$((($im-1)/($nu-1)))
              echo $(($im-($nu-1)*$r+1)) $(($im-($nu-1)*$r))
              compare $(($im-($nu-1)*$r+1)).png $(($im-($nu-1)*$r)).png ${DES}/${name}_${im}.png
              echo ${name}_${im}.png ${category[-1]}  >> $TXT_PATH/train.txt
            done   
        fi
      done
    done
  done
done
