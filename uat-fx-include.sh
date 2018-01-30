#!/bin/bash

PASSCOUNT=0
FAILCOUNT=0

start(){
    echo "---------------------------------------------"
    echo "starting test suite: $1"
    echo "---------------------------------------------"
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


    if [[ "$EXPECTED" == "$ACTUAL" ]]; then
        pass "$TESTNAME"
    else
        echo "EXPECTED: [$EXPECTED]"
        echo "ACTUAL  : [$ACTUAL]"
        fail "$TESTNAME" "$EXPECTED" "$ACTUAL"
    fi
}

notequals(){
    TESTNAME="$1"
    EXPECTED="$2"
    ACTUAL="$3"

    if [[ "$EXPECTED" != "$ACTUAL" ]]; then
        pass "$TESTNAME"
    else
        echo "EXPECTED: not[$EXPECTED]"
        echo "ACTUAL  : [$ACTUAL]"
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

notcontains(){
    TESTNAME="$1"
    TEXT="$2"
    CONTAINS="$3"

    if ! echo "$TEXT" | grep -q -F "$CONTAINS"; then
        pass "$TESTNAME"
    else
        fail "$TESTNAME" "[$TEXT] to not contain [$CONTAINS]" "[$TEXT] contains [$CONTAINS]"
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

jqcompare(){
    TESTNAME="$1"
    JQS="$2"
    JSON="$3"

    if echo "$JSON" | jq -e "$JQS"; then
      pass "$TESTNAME"
    else
      fail "$TESTNAME" "$JQS" "$(echo "$JSON"|jq '')"
    fi
}

failcritical(){
    echo "****** ERROR *****: Experienced critical failure: $1"
    exit 1
}

finish(){
    NOEXIT="$1"
    if [[ "$FAILCOUNT" == "0" ]]; then
        echo "****** TESTS COMPLETE ******"
        echo "passed: $PASSCOUNT"
        echo "failed: $FAILCOUNT"
        echo "****************************"
    else
        echo "!!!!!! TESTS FINISHED WITH FAILURES !!!!!!"
        echo "passed: $PASSCOUNT"
        echo "failed: ${FAILCOUNT}***"
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        if [[ "$NOEXIT" != "--noexit" ]]; then
            exit 1
        fi
    fi
}
