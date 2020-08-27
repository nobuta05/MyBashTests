#!/bin/bash
source ./common.sh

assert_ok "echo huga" 0
assert_not_ok "cat hoge.sh" 1