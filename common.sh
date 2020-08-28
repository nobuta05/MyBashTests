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
  echo -e "${ng_status} [$4] $1\n    expected:\t$2\n    result:\t$3"
}

assert_equals() {
  # assert_equals <command> <expected stdout>
  local expected=$(echo -ne "${2:-}")
  local result=$(eval "$1 2> /dev/null")
  if [[ $result == $expected ]]; then
    echo "${ok_status} [${FUNCNAME[0]}] $1"
  else
    local ret=$(failed_msg "$1" $expected $result ${FUNCNAME[0]})
    echo $ret
    (( tests_failed++ )) || :
  fi
  (( tests_ran++ )) || :
}

assert_ok() {
  # assert_ok <command>
  eval "$1 > /dev/null 2>&1"
  local result=$?
  if [[ $result == 0 ]]; then
    echo "${ok_status} [${FUNCNAME[0]}] $1"
  else
    local ret=$(failed_msg "$1" "0" $result ${FUNCNAME[0]})
    echo $ret
    (( tests_failed++ )) || :
  fi
  (( tests_ran++ )) || :
}

assert_not_ok() {
  # assert_not_ok <command>
  eval "$1 > /dev/null 2>&1"
  local result=$?
  if [[ $result == 1 ]]; then
    echo "${ok_status} [${FUNCNAME[0]}] $1"
  else
    local ret=$(failed_msg "$1" "1" $result ${FUNCNAME[0]})
    echo $ret
    (( tests_failed++ )) || :
  fi
  (( tests_ran++ )) || :
}

assert_ng() {
  # assert_ng <command> <expected return code>
  eval "$1 > /dev/null 2>&1"
  local result=$?
  local expected=$2
  if [[ $result == $expected ]]; then
    echo "${ok_status} [${FUNCNAME[0]}] $1"
  else
    local ret=$(failed_msg "$1" $expected $result ${FUNCNAME[0]})
    echo $ret
    (( tests_failed++ )) || :
  fi
  (( tests_ran++ )) || :
}