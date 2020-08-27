#!/bin/bash
ok_status=$'\e[32m✔\e[m'
ng_status=$'\e[31m✖\e[m'

_tests_reset() {
  tests_ran=0
  tests_failed=0
}
tests_result() {
  echo -n "${ok_status}: $(( ${tests_ran} - ${tests_failed} )), "
  echo -n "${ng_status}: ${tests_failed}, "
  echo "total: ${tests_ran}"

  _tests_reset
}

failed_msg() {
  # failed_msg <command> <expected> <result> <kind of test>
  echo "${ng_status} <$4> $1
  expected:\t$2
  result:\t$3"
}

assert_equals() {
  # assert_equals <command> <expected stdout>
  local expected=$(echo -ne "${2:-}")
  local result=$(eval "$1 2> /dev/null")
  if [[ $result == $expected ]]; then
    echo "${ok_status} <$0> $1"
  else
    failed_msg $1 $expected $result $0
    (( tests_failed++ )) || :
  fi
  (( tests_ran++ )) || :
}

assert_ok() {
  # assert_ok <command>
  eval $1 > /dev/null 2>&1
  local result=$?
  if [[ $result == 0 ]]; then
    echo "${ok_status} <$0> $1"
  else
    failed_msg $1 "0" $result $0
    (( tests_failed++ )) || :
  fi
  (( tests_ran++ )) || :
}

assert_not_ok() {
  # assert_not_ok <command>
  eval $1 > /dev/null 2>&1
  local result=$?
  if [[ $result == 1 ]]; then
    echo "${ok_status} <$0> $1"
  else
    failed_msg $1 "1" $result $0
    (( tests_failed++ )) || :
  fi
  (( tests_ran++ )) || :
}
