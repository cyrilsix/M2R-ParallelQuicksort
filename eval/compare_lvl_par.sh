#!/bin/bash

evaluate=./util/evaluate.sh

echo "### Comparing different thread levels for the parallel version"
echo "## output will be in results/thread_level"

echo "# Building with THREAD_LEVEL=1"
make -C ../src/ clean
make -C ../src/ THREAD_LEVEL='-D THREAD_LEVEL=1'
echo "# Computing"
$evaluate 100000 --version=par > results/par_lvl_1.dat

echo "# Building with THREAD_LEVEL=5"
make -C ../src/ clean
make -C ../src/ THREAD_LEVEL='-D THREAD_LEVEL=5'
echo "# Computing"
$evaluate 100000 --version=par > results/par_lvl_5.dat

echo "# Building with THREAD_LEVEL=10"
make -C ../src/ clean
make -C ../src/ THREAD_LEVEL='-D THREAD_LEVEL=10'
echo "# Computing"
$evaluate 100000 --version=par > results/par_lvl_10.dat

echo "# Building with THREAD_LEVEL=20"
make -C ../src/ clean
make -C ../src/ THREAD_LEVEL='-D THREAD_LEVEL=20'
echo "# Computing"
$evaluate 100000 --version=par > results/par_lvl_20.dat

echo "# Building with THREAD_LEVEL=50"
make -C ../src/ clean
make -C ../src/ THREAD_LEVEL='-D THREAD_LEVEL=50'
echo "# Computing"
$evaluate 100000 --version=par > results/par_lvl_50.dat

echo "# Building with THREAD_LEVEL=100"
make -C ../src/ clean
make -C ../src/ THREAD_LEVEL='-D THREAD_LEVEL=100'
echo "# Computing"
$evaluate 100000 --version=par > results/par_lvl_100.dat

echo "Plotting.."
cd results
gnuplot thread_level.gpi
cd ..
