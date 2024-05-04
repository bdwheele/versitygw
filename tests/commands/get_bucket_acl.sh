#!/usr/bin/env bash

get_bucket_acl() {
  if [ $# -ne 1 ]; then
    echo "bucket ACL command missing bucket name"
    return 1
  fi
  local exit_code=0
  acl=$(aws --no-verify-ssl s3api get-bucket-acl --bucket "$1" 2>&1) || exit_code="$?"
  if [ $exit_code -ne 0 ]; then
    echo "Error getting bucket ACLs: $acl"
    return 1
  fi
  export acl
}