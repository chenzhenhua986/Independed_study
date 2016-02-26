TOOLS=/u/chen478/caffe/build/tools
ROOT=/nobackup/chen478/UCF
DATA=/scratch/chen478/UCF/UCF_diff_test

rm -rf $ROOT/train_lmdb 
echo "Creating train lmdb from directory: "$DATA
    GLOG_logtostderr=1  $TOOLS/convert_imageset \
    $DATA/ \
    $ROOT/train.txt \
    $ROOT/train_lmdb
echo "Done."



