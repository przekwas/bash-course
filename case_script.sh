#!/bin/bash
read -p "Enter a number: " number
case "$number" in
  [0-9]) 
    echo "you have entered a single digit number";;
  [0-9][0-9])
    echo "you have entered a double digit number";;
  [0-9][0-9][0-9])
    echo "you have entered a triple digit number";;
  *)
    echo "you have entered a number with more than three digits";;
esac