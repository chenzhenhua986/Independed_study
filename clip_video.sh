VIDEO_PATH=UCF
DES=videoData
step=13 # Sliding window step

c_no=1
v_no=1
for c in $VIDEO_PATH/*;do
  if [ ! -d "$DES/category_$c_no" ]; then
    mkdir $DES/category_$c_no
  fi
  for v in $c/*;do 
    if [ ! -d "$DES/category_$c_no/video_$v_no" ]; then
      mkdir $DES/category_$c_no/video_$v_no        
    fi
    IFS='/' read -r -a array <<< "$v"
    echo ${array[-1]}
    ffmpeg -loglevel panic -i $v -vf scale=256:256 -y $DES/${array[-1]}
    ffmpeg -loglevel panic -i $DES/${array[-1]} -filter:v "crop=224:224:0:0" $DES/category_$c_no/video_$v_no/crop_1.avi
    ffmpeg -loglevel panic -i $DES/${array[-1]} -filter:v "crop=224:224:16:0" $DES/category_$c_no/video_$v_no/crop_2.avi
    ffmpeg -loglevel panic -i $DES/${array[-1]} -filter:v "crop=224:224:32:0" $DES/category_$c_no/video_$v_no/crop_3.avi
    ffmpeg -loglevel panic -i $DES/${array[-1]} -filter:v "crop=224:224:0:16" $DES/category_$c_no/video_$v_no/crop_4.avi
    ffmpeg -loglevel panic -i $DES/${array[-1]} -filter:v "crop=224:224:16:16" $DES/category_$c_no/video_$v_no/crop_5.avi
    ffmpeg -loglevel panic -i $DES/${array[-1]} -filter:v "crop=224:224:32:16" $DES/category_$c_no/video_$v_no/crop_6.avi
    ffmpeg -loglevel panic -i $DES/${array[-1]} -filter:v "crop=224:224:0:32" $DES/category_$c_no/video_$v_no/crop_7.avi
    ffmpeg -loglevel panic -i $DES/${array[-1]} -filter:v "crop=224:224:16:32" $DES/category_$c_no/video_$v_no/crop_8.avi
    ffmpeg -loglevel panic -i $DES/${array[-1]} -filter:v "crop=224:224:32:32" $DES/category_$c_no/video_$v_no/crop_9.avi
    rm -f $DES/${array[-1]} # remove the videos
    for i in {1..9}; do
      if [ ! -d "$DES/category_$c_no/video_$v_no/crop_i" ]; then
        mkdir $DES/category_$c_no/video_$v_no/crop_$i
      fi
      ffmpeg -loglevel panic -i $DES/category_$c_no/video_$v_no/crop_${i}.avi $DES/category_$c_no/video_$v_no/crop_${i}/%d.png

      nu=$(ls $DES/category_$c_no/video_$v_no/crop_${i}/  | wc -l)
      file_no=1
      for ((k=1-step; k<=0; k++));do
        for ((j=1; j<=(($nu/step)); j++));do
          if [ ! -d "$DES/category_$c_no/video_$v_no/crop_${i}/clip_$file_no" ]; then
            mkdir $DES/category_$c_no/video_$v_no/crop_${i}/clip_$file_no
          fi
          mv $DES/category_$c_no/video_$v_no/crop_${i}/$((k+j*step)).png $DES/category_$c_no/video_$v_no/crop_${i}/clip_$file_no
          mv $DES/category_$c_no/video_$v_no/crop_${i}/clip_$file_no/$((k+j*step)).png $DES/category_$c_no/video_$v_no/crop_${i}/clip_$file_no/${j}.png
        done
      file_no=$((file_no+1))
      done
      rm -f $DES/category_$c_no/video_$v_no/crop_${i}/*.png   # remove the remaining frames
    done
    rm -f $DES/category_$c_no/video_$v_no/*.avi    # remove the cropped videos
    
    v_no=$((v_no+1))
  done
  c_no=$((c_no+1))
done
