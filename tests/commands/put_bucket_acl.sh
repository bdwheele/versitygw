#!/usr/bin/env bash

put_bucket_acl() {
  if [[ $# -ne 3 ]]; then
    log 3 "put bucket acl command requires command type, bucket name, acls"
    return 1
  fi
  local error=""
  local put_result=0
  if [[ $1 == 's3api' ]]; then
    error=$(aws --no-verify-ssl s3api put-bucket-acl --bucket "$2" --acl "$3" 2>&1) || put_result=$?
  elif [[ $1 == 's3cmd' ]]; then
    error=$(s3cmd "${S3CMD_OPTS[@]}" --no-check-certificate setacl --acl-"$3" "s3://$2" 2>&1) || put_result=$?
  else
    log 2 "put_bucket_acl not implemented for '$1'"
    return 1
  fi
  if [[ $put_result -ne 0 ]]; then
    log 2 "error putting bucket acl: $error"
    return 1
  fi
  return 0
}