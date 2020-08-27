#!/bin/bash
SCRIPTDIR=$(cd $(dirname $0); pwd)
source ${SCRIPTDIR}/common.sh

_tests_reset
for test_source in `ls ${SCRIPTDIR}/test_*.sh`; do
  source ${test_source}
done
tests_result