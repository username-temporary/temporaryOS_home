#!/bin/bash
result=$(dunstctl is-paused) #result is either true or false

if [ $result == "true" ] 
then
  echo "%{F#a8abaa}N%{F-}" #notifications off
else 
  echo "%{F#109ec9}N%{F-}" #notifications on
fi  
