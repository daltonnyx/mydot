#!/bin/bash


procs=$(ps aux | awk '$8~/T/' | awk '$0!~/suspend/' | awk '{print $2}' | sed '1d')

for p in $procs
do
    echo $p | xargs kill -CONT
done
