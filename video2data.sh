VIDEO_PATH=videos
DES=videoData
step=13 # Sliding window step

v_no=1
for v in $VIDEO_PATH/*;do
  mkdir $DES/video_$v_no
  ffmpeg -i $v  %d.png # split video to image sequences
  mkdir tmp
  mv *.png tmp

  # count the total number of images
  nu=0
  for i in tmp/*;do
    nu=$((nu+1))
  done

  file_no=1
  for ((i=1-step; i<=0; i++));do 
    for ((j=1; j<=(($nu/step)); j++));do
      mkdir $DES/video_$v_no/$file_no      
      mv tmp/$((i+j*step)).png $DES/video_$v_no/$file_no
    done
  file_no=$((file_no+1))
  done
  rm -rf tmp
  v_no=$((v_no+1))
done

# Resize and crop images
for i in $DES/*;do
  for j in $i/*;do
    crop_nu=1
    for k in $j/*;do
      IFS='/' read -r -a array <<< "$k"
      ffmpeg -i $k -vf scale=256:256 -y $k
      if [ $crop_nu==1 ]
      then
	mkdir $j/crop_1
        mkdir $j/crop_2
        mkdir $j/crop_3
        mkdir $j/crop_4
        mkdir $j/crop_5
        mkdir $j/crop_6
        mkdir $j/crop_7
        mkdir $j/crop_8
        mkdir $j/crop_9
      fi

      ffmpeg -i $k -vf  "crop=224:224:0:0" $j/crop_${array[-1]}
      mv $j/crop_${array[-1]} $j/crop_1
      ffmpeg -i $k -vf  "crop=224:224:16:0" $j/crop_${array[-1]}
      mv $j/crop_${array[-1]} $j/crop_2
      ffmpeg -i $k -vf  "crop=224:224:32:0" $j/crop_${array[-1]}
      mv $j/crop_${array[-1]} $j/crop_3              
      ffmpeg -i $k -vf  "crop=224:224:0:16" $j/crop_${array[-1]}
      mv $j/crop_${array[-1]} $j/crop_4
      ffmpeg -i $k -vf  "crop=224:224:16:16" $j/crop_${array[-1]}
      mv $j/crop_${array[-1]} $j/crop_5              
      ffmpeg -i $k -vf  "crop=224:224:32:16" $j/crop_${array[-1]}
      mv $j/crop_${array[-1]} $j/crop_6
      ffmpeg -i $k -vf  "crop=224:224:0:32" $j/crop_${array[-1]}
      mv $j/crop_${array[-1]} $j/crop_7 
      ffmpeg -i $k -vf  "crop=224:224:16:32" $j/crop_${array[-1]}
      mv $j/crop_${array[-1]} $j/crop_8              
      ffmpeg -i $k -vf  "crop=224:224:32:32" $j/crop_${array[-1]}
      mv $j/crop_${array[-1]} $j/crop_9

      crop_nu=$((crop_nu+1))
    done
    rm -f $j/*.png
  done
done 
