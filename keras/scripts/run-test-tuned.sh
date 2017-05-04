#!/bin/bash

SLEEPTIME=30    # Seconds to sleep between invoking sbatch
REPETITIONS=10    # Number of repetitions to run
WORDVECS="wordvecs/Chiu-win-2.bin"

# Best from parameter selection
PARAMS="--filter-sizes 2 3 4 --filter-nums 100 100 100 --oversample"

for i in $(seq $REPETITIONS); do
    sbatch ./batchall.sh "$WORDVECS" $PARAMS --test
    sleep $SLEEPTIME
done
