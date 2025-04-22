#!/bin/bash

# simple conditions
#if [ 2 -gt 2 ]; then
#    echo test passed
#else
#    echo test failed
#fi

# chain conditions
a=$(cat file1.txt)
b=$(cat file2.txt)
c=$(cat file3.txt)
if [ $a = $b ] && [ $a = $c ]; then
    rm file2.txt file3.txt
else
    echo "Files do not match"
fi