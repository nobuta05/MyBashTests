#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
source ${SCRIPTDIR}/common.sh

assert_equals "echo 'huga'" "huga"
assert_ok "cat ${SCRIPTDIR}/test_hoge.sh"