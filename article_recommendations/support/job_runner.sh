#!/bin/bash

set -e

BASE_DIR=/mnt/var/hadoop-jobs

job_name=$1
shift
job_id=$1
shift
job_bucket=$1
shift
input_glob=$1
shift
output_path=$1
shift
hadoop_args="$input_glob $output_path $*"

target_dir="$BASE_DIR/$job_id"

sudo mkdir -p $target_dir
sudo chown hadoop:hadoop $target_dir
cd $target_dir

aws s3 sync s3://$job_bucket/$job_id/ .

run_jar="hadoop jar $job_name.jar $job_name $input_glob $output_path $hadoop_args"
copy_log_s3="aws s3 cp log.out s3://$job_bucket/$job_id/"

setsid nohup bash -c "$run_jar && $copy_log_s3" >>log.out 2>&1 &

echo "Job started"
exit 0
