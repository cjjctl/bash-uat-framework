#!/bin/bash

PASSCOUNT=0
FAILCOUNT=0

start(){
    echo "---------------------------------------------"
    echo "starting test suite: $1"
    # TODO Test that this resets the count.
    PASSCOUNT=0
    FAILCOUNT=0
}

pass(){
    (( PASSCOUNT++ ))
    echo "---passed test: $1"
}


fail(){
    (( FAILCOUNT++ ))
    echo "---failed test: $1"
    echo "---expected: $2"
    echo "---actual  : $3"
}

equals(){
    TESTNAME="$1"
    EXPECTED="$2"
    ACTUAL="$3"

    echo "EXPECTED: [$EXPECTED]"
    echo "ACTUAL  : [$ACTUAL]"

    if [[ "$EXPECTED" == "$ACTUAL" ]]; then
        pass "$TESTNAME"
    else
        fail "$TESTNAME" "$EXPECTED" "$ACTUAL"
    fi
}

contains(){
    TESTNAME="$1"
    TEXT="$2"
    CONTAINS="$3"

    if echo "$TEXT" | grep -q -F "$CONTAINS"; then
        pass "$TESTNAME"
    else
        fail "$TESTNAME" "[$TEXT] to contain [$CONTAINS]" "[$TEXT] does not contain [$CONTAINS]"
    fi
}

matches(){
    TESTNAME="$1"
    TEXT="$2"
    REGEX="$3"

    if echo "$TEXT" | grep -q -P "$REGEX"; then
        pass "$TESTNAME"
    else
        fail "$TESTNAME" "[$TEXT] to contain regex [$REGEX]" "[$TEXT] does not contain regex [$REGEX]"
    fi
}

finish(){
    echo "******* TESTS COMPLETE "
    echo "passed: $PASSCOUNT"
    echo "failed: $FAILCOUNT"
    echo "*******"
}
