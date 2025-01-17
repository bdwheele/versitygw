#!/bin/bash

if [[ -z "$VERSITYGW_TEST_ENV" ]]; then
  echo "Error:  VERSITYGW_TEST_ENV parameter must be set"
  exit 1
fi

# shellcheck source=./.env.default
source "$VERSITYGW_TEST_ENV"
export RECREATE_BUCKETS

if ! ./tests/run.sh aws; then
  exit 1
fi
if ! ./tests/run.sh s3; then
  exit 1
fi
if ! ./tests/run.sh s3cmd; then
  exit 1
fi
if ! ./tests/run.sh mc; then
  exit 1
fi
if ! ./tests/run.sh user; then
  exit 1
fi
exit 0
