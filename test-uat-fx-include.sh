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

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 3"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 2"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT2 - Test start resets counts
############

start 'UAT2 - Test start resets counts Expect: pass 1, fail 1'

pass "UAT2.1"
fail "UAT2.2" "This was expected" "This was actual"

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

start 'UAT2 - reset the count Expect: pass 0, fail 0'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT3 - Test equals
############
start 'UAT3 - Test equals Expect: pass 1'

equals 'UAT3' 'apples' 'apples'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT4 - Test not equals
############
start 'UAT4 - Test not equals Expect: fail 1'

equals 'UAT4' 'apples' 'pears'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT5 - Test equals using regex - should not work
############
start 'UAT5 - Test equals using regex Expect: fail 1'

equals 'UAT5' '.*' 'pears'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT6 - Test contains - happy
############
start 'UAT6 - Test contains - happy Expect: pass 1'

contains 'UAT6' 'This is a sentence that we are testing.' 'sentence'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT7 - Test contains - sad
############
start 'UAT7 - Test contains - sad Expect: fail 1'

contains 'UAT7' 'This is a sentence that we are testing.' 'blah'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT8 - Test contains with regex
############
start 'UAT8 - Test contains with regex Expect: fail 1'

contains 'UAT8' 'This is a sentence that we are testing.' '.*'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT9 - Test matches with regex - happy
############
start 'UAT9 - Test matches with regex Expect: pass 1'

matches 'UAT9' 'This is a sentence that we are testing.' '^This.*?sentence.*?\.$'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT10 - Test matches with regex - sad
############
start 'UAT10 - Test matches with regex Expect: fail 1'

matches 'UAT10' 'This is a sentence that we are testing.' '^This.*blah'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT11 - Test notcontains - happy
############
start 'UAT11 - Test notcontains - happy Expected: pass 1'

notcontains 'UAT11' 'This is a sentence that we are testing.' 'apples'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT12 - Test notcontains - sad
############
start 'UAT12 - Test notcontains - sad Expected: fail 1'

notcontains 'UAT12' 'This is a sentence that we are testing.' 'testing'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT13 - Test notequals - happy
############
start 'UAT13 - Test notequals - happy Expect: pass 1'

notequals 'UAT13' 'pears' 'apples'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT14 - Test notequals - sad
############
start 'UAT14 - Test notequals - sad Expect: fail 1'

notequals 'UAT14' 'pears' 'pears'

FINISH_OUT=$(finish --noexit)

if ! echo $FINISH_OUT | grep -q "failed: 1"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

if ! echo $FINISH_OUT | grep -q "passed: 0"; then
    echo "TEST OF uat-fx-include.sh HAS FAILED! LINE: $LINENO"
    exit 1
fi

############
### UAT-X - Test critical failure
############
start 'UAT-X - Test critical failure Expect: output finish then end tests'

failcritical "This should end this test script"

echo "if you see this, then criticalfailure did not work"

exit 0

