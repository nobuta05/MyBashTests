#!/bin/bash
TESTDIR=$(cd $(dirname ${FUNCNAME[0]:-$0}); pwd)
source ${TESTDIR}/common.sh

_tests_reset
for test_source in `ls ${TESTDIR}/test_*.sh`; do
  source ${test_source}
done
tests_result