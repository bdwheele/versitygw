#!/usr/bin/env bash

put_bucket_acl() {
  if [[ $# -ne 3 ]]; then
    echo "put bucket acl command requires command type, bucket name, acls"
    return 1
  fi
}