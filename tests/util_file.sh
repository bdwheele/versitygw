#!/usr/bin/env bats

source ./tests/logger.sh

# create a test file and export folder.  do so in temp folder
# params:  filename
# export test file folder on success, return 1 for error
create_test_files() {
  if [ $# -lt 1 ]; then
    echo "create test files command missing filename"
    return 1
  fi
  test_file_folder=$PWD
  if [[ -z "$GITHUB_ACTIONS" ]]; then
    create_test_file_folder
  fi
  for name in "$@"; do
    touch "$test_file_folder"/"$name" || local touch_result=$?
    if [[ $touch_result -ne 0 ]]; then
      echo "error creating file $name"
    fi
  done
  export test_file_folder
}

create_test_folder() {
  if [ $# -lt 1 ]; then
    echo "create test folder command missing folder name"
    return 1
  fi
  test_file_folder=$PWD
  if [[ -z "$GITHUB_ACTIONS" ]]; then
    create_test_file_folder
  fi
  for name in "$@"; do
    mkdir -p "$test_file_folder"/"$name" || local mkdir_result=$?
    if [[ $mkdir_result -ne 0 ]]; then
      echo "error creating file $name"
    fi
  done
}

# delete a test file
# params:  filename
# return:  0 for success, 1 for error
delete_test_files() {
  if [ $# -lt 1 ]; then
    echo "delete test files command missing filenames"
    return 1
  fi
  if [ -z "$test_file_folder" ]; then
    echo "no test file folder defined, not deleting"
    return 1
  fi
  for name in "$@"; do
    rm -rf "${test_file_folder:?}"/"${name:?}" || rm_result=$?
    if [[ $rm_result -ne 0 ]]; then
      echo "error deleting file $name"
    fi
  done
  return 0
}

# split file into pieces to test multipart upload
# param: file location
# return 0 for success, 1 for error
split_file() {
  file_size=$(stat -c %s "$1" 2>/dev/null || stat -f %z "$1" 2>/dev/null)
  part_size=$((file_size / $2))
  remainder=$((file_size % $2))
  if [[ remainder -ne 0 ]]; then
    part_size=$((part_size+1))
  fi

  local error
  local split_result
  error=$(split -a 1 -d -b "$part_size" "$1" "$1"-) || split_result=$?
  if [[ $split_result -ne 0 ]]; then
    echo "error splitting file: $error"
    return 1
  fi
  return 0
}

# compare files
# input:  two files
# return 0 for same data, 1 for different data, 2 for error
compare_files() {
  if [ $# -ne 2 ]; then
    echo "file comparison requires two files"
    return 2
  fi
  file_one_md5=$(md5 -q "$1")
  file_two_md5=$(md5 -q "$2")
  if [[ $file_one_md5 == "$file_two_md5" ]]; then
    return 0
  fi
  return 1
}

create_test_file_folder() {
  if [[ -n $TMPDIR ]]; then
    test_file_folder=${TMPDIR}versity-gwtest
  else
    test_file_folder=$PWD/versity-gwtest
  fi
  mkdir -p "$test_file_folder" || local mkdir_result=$?
  if [[ $mkdir_result -ne 0 ]]; then
    echo "error creating test file folder"
  fi
  export test_file_folder
}

# generate 16MB file
# input: filename
# return 0 for success, 1 for error
create_large_file() {
  if [[ $# -ne 1 ]]; then
    echo "generate large file function requires filename"
    return 1
  fi

  test_file_folder=$PWD
  if [[ -z "$GITHUB_ACTIONS" ]]; then
    create_test_file_folder
  fi

  filesize=$((160*1024*1024))
  error=$(dd if=/dev/urandom of="$test_file_folder"/"$1" bs=1024 count=$((filesize/1024))) || dd_result=$?
  if [[ $dd_result -ne 0 ]]; then
    echo "error creating file: $error"
    return 1
  fi
  return 0
}

create_test_file_count() {
  if [[ $# -ne 1 ]]; then
    echo "create test file count function missing bucket name, count"
    return 1
  fi
  test_file_folder=$PWD
  if [[ -z "$GITHUB_ACTIONS" ]]; then
    create_test_file_folder
  fi
  local touch_result
  for ((i=1;i<=$1;i++)) {
    error=$(touch "$test_file_folder/file_$i") || touch_result=$?
    if [[ $touch_result -ne 0 ]]; then
      echo "error creating file_$i:  $error"
      return 1
    fi
  }
  if [[ $LOG_LEVEL -ge 5 ]]; then
    ls_result=$(ls "$test_file_folder"/file_*)
    log 5 "$ls_result"
  fi
  return 0
}
