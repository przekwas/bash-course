#!/bin/bash

# Check if $HOME/source/bash-course/performance exists
# If not, create it
# If it exists, echo "Directory already exists"
if [ -d "$HOME/source/bash-course/performance" ]; then
    echo "Directory already exists"
else
    mkdir -p "$HOME/source/bash-course/performance"
fi

free >> "$HOME/source/bash-course/performance/memory.log"