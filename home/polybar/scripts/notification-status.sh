#!/bin/bash
result=$(dunstctl is-paused) #result is either true or false

if [ $result == "true" ] 
then
  echo "%{F#707880}N%{F-}" #notifications off
else 
  echo "%{F#109EC9}N%{F-}" #notifications on
fi  
