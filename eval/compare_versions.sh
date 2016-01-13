#!/bin/bash

evaluate=./util/evaluate.sh
max=10000000

echo "###Comparing different versions"
echo "output will be in results/versions"
echo "Compiling"
make -C ../src/ clean
make -C ../src/

echo "Computing sequential version (maximum size : $max)"
$evaluate $max --version=seq > results/seq.dat

echo "Computing parallel version (maximum size : $max)"
$evaluate $max --version=par > results/par.dat

echo "Computing built-in version (maximum size : $max)"
$evaluate $max --version=libc > results/libc.dat

echo "Plotting.."
cd results
gnuplot versions.gpi
cd ..
