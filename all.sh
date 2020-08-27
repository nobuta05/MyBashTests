#!/bin/bash

source ./common.sh
_tests_reset

for test_source in `ls ./test_*.sh`; do
  source ${test_source}
done

tests_result