#!/bin/bash

evaluate=./util/evaluate.sh
max=10000000

echo "### Comparing different optimizations for the sequential version"
echo "## output will be in results/optimizations"

echo "# Building -O0"
make -C ../src/ clean
make -C ../src/ OPT=-O0
echo "# Computing -O0"
$evaluate $max --version=seq > results/seqO0.dat

echo "# Building -O1"
make -C ../src/ clean
make -C ../src/ OPT=-O1
echo "# Computing -O1"
$evaluate $max --version=seq > results/seqO1.dat

echo "# Building -O2"
make -C ../src/ clean
make -C ../src/ OPT=-O2
echo "# Computing -O2"
$evaluate $max --version=seq > results/seqO2.dat

echo "# Building -O3"
make -C ../src/ clean
make -C ../src/ OPT=-O3
echo "# Computing -O3"
$evaluate $max --version=seq > results/seqO3.dat

echo "Plotting.."
cd results
gnuplot optimizations_seq.gpi
cd ..
