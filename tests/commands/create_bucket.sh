#!/usr/bin/env bash

# create an AWS bucket
# param:  bucket name
# return 0 for success, 1 for failure
create_bucket() {
  if [ $# -ne 2 ]; then
    echo "create bucket missing command type, bucket name"
    return 1
  fi

  local exit_code=0
  local error
  if [[ $1 == 's3' ]]; then
    error=$(aws --no-verify-ssl s3 mb s3://"$2" 2>&1) || exit_code=$?
  elif [[ $1 == "aws" ]] || [[ $1 == 's3api' ]]; then
    error=$(aws --no-verify-ssl s3api create-bucket --bucket "$2" 2>&1) || exit_code=$?
  elif [[ $1 == "s3cmd" ]]; then
    error=$(s3cmd "${S3CMD_OPTS[@]}" --no-check-certificate mb s3://"$2" 2>&1) || exit_code=$?
  elif [[ $1 == "mc" ]]; then
    error=$(mc --insecure mb "$MC_ALIAS"/"$2" 2>&1) || exit_code=$?
  else
    echo "invalid command type $1"
    return 1
  fi
  if [ $exit_code -ne 0 ]; then
    echo "error creating bucket: $error"
    return 1
  fi
  return 0
}
