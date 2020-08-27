#!/bin/bash
source ./common.sh

assert_equals "echo 'huga'" "huga"
assert_ok "cat test_hoge.sh"