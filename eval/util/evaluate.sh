#!/bin/bash

##
# Evaluates the quicksort by analyzing computation time for varied sizes
# The size varies logarithmically from 1 to $1
# $2 gives the wanted version (--version={seq, par, libc})
##

usage(){
    echo "Usage : ./evaluate.sh max --version={seq,par,libc}"
}

if [ "$#" -ne 2 ]; then
    usage
    exit
fi

quicksort='../src/parallelQuicksort'
nb_samples=30

version=`echo $2 | awk -F "=" '{print $2}'`
if [ $version = "seq" ]; then
    version=1
elif [ $version = "par" ]; then
    version=2
elif [ $version = "libc" ]; then
    version=3
else
    usage
    exit
fi

# Sets inputs variable with a log range from 1 to $1
set_inputs_log(){
    max=$1
    digit=1
    input=1
    scale=1
    inputs=""

    while [ $input -le $max ]; do
        inputs="$inputs $input"
        if (( $digit == 1 )); then
            digit=2
        elif (( $digit == 2 )); then
            digit=5
        elif (( $digit == 5 )); then
            digit=1
            scale=$(($scale * 10))
        fi

        input=$(($digit * $scale))
    done
}

# Script core
set_inputs_log $1
echo "size time_avg time_std"
for input in $inputs; do
    outputs=""
    #min=0
    #max=0
    for i in `seq 1 $nb_samples`; do
        output=`$quicksort $input $version | awk -F " " '{print $4}'`
        #if [ $i -eq 1 ]; then
        #    min=$output
        #    max=$output
        #else
        #    if [ 1 -eq "$(echo "${output} < ${min}" | bc)" ]; then
        #        min=${output}
        #    fi
        #    if [ 1 -eq "$(echo "${output} > ${max}" | bc)" ]; then
        #        max=${output}
        #    fi
        #fi
        outputs="$outputs $output"
    done
    # output <- avg(outputs)
    output=`echo $outputs | tr ' ' '\n' | awk '{s+=$1; n++} END {print s/n}'`
    std=`echo $outputs | tr ' ' '\n' | awk '{sum+=$1; sumsq+=$1*$1}END{print sqrt(sumsq/NR - (sum/NR)**2)}'`
    echo "$input $output $std"
done
