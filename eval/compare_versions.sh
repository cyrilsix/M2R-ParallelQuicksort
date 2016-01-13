#!/bin/bash

evaluate=./util/evaluate.sh

echo "###Comparing different versions"
echo "output will be in results/versions"
echo "Compiling"
make -C ../src/ clean
make -C ../src/

echo "Computing sequential version"
$evaluate 100000 --version=seq > results/seq.dat

echo "Computing parallel version"
$evaluate 100000 --version=par > results/par.dat

echo "Computing built-in version"
$evaluate 100000 --version=libc > results/libc.dat

echo "Plotting.."
cd results
gnuplot versions.gpi
cd ..
