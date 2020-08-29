#!/bin/bash

assert_equals "echo 'huga'" "huga"
assert_ok "cat ${SCRIPTDIR}/test_hoge.sh"
assert_ng "ping -i a -c 5 127.0.0.1" 2
assert_ok "ping -i 1 -c 5 127.0.0.1"