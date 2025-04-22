#!/bin/bash

PS3="What type of character do you play?: "
select charType in luchador "war criminal" himbo "all the above"; do
  echo "You selected $charType"
  break
done

echo "$charType" >> data.txt
