#!/usr/bin/env bash

get_bucket_versioning() {
  if [[ $# -ne 2 ]]; then
    echo "put bucket versioning command requires command type, bucket name"
    return 1
  fi
  local get_result=0
  if [[ $1 == 's3api' ]]; then
    error=$(aws --no-verify-ssl s3api get-bucket-versioning --bucket "$2" 2>&1) || get_result=$?
  fi
  if [[ $get_result -ne 0 ]]; then
    echo "error getting bucket versioning: $error"
    return 1
  fi
  echo $error
  return 0
}