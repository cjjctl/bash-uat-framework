#!/bin/bash

. uat-fx-include.sh

############
### UAT1 - Test "start", "pass" x2, "fail" x3, "finish" ###
############

start 'UAT1 - Test "start", "pass" x2, "fail" x3, "finish" Expect: pass 2, fail 3'

pass "UAT1.1"
pass "UAT1.2"
fail "UAT1.3" "This was expected" "This was actual"
fail "UAT1.4" "This was expected" "This was actual"
fail "UAT1.5" "This was expected" "This was actual"

finish

############
### UAT2 - Test start resets counts
############

start 'UAT2 - Test start resets counts Expect: pass 1, fail 1'

pass "UAT2.1"
fail "UAT2.2" "This was expected" "This was actual"

finish

start 'UAT2 - reset the count Expect: pass 0, fail 0'

finish

############
### UAT3 - Test equals
############
start 'UAT3 - Test equals Expect: pass 1'

equals 'UAT3' 'apples' 'apples'

finish

############
### UAT4 - Test not equals
############
start 'UAT4 - Test not equals Expect: fail 1'

equals 'UAT4' 'apples' 'pears'

finish

############
### UAT5 - Test equals using regex - should not work
############
start 'UAT5 - Test equals using regex Expect: fail 1'

equals 'UAT5' '.*' 'pears'

finish

############
### UAT6 - Test contains - happy
############
start 'UAT6 - Test contains - happy Expect: pass 1'

contains 'UAT6' 'This is a sentence that we are testing.' 'sentence'

finish

############
### UAT7 - Test contains - sad
############
start 'UAT7 - Test contains - sad Expect: fail 1'

contains 'UAT7' 'This is a sentence that we are testing.' 'blah'

finish

############
### UAT8 - Test contains with regex
############
start 'UAT8 - Test contains with regex Expect: fail 1'

contains 'UAT8' 'This is a sentence that we are testing.' '.*'

finish

############
### UAT9 - Test matches with regex - happy
############
start 'UAT9 - Test matches with regex Expect: pass 1'

matches 'UAT9' 'This is a sentence that we are testing.' '^This.*?sentence.*?\.$'

finish

############
### UAT10 - Test matches with regex - sad
############
start 'UAT10 - Test matches with regex Expect: fail 1'

matches 'UAT10' 'This is a sentence that we are testing.' '^This.*blah'

finish


exit 0

