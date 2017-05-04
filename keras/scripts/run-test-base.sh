#!/bin/bash

SLEEPTIME=30    # Seconds to sleep between invoking sbatch
REPETITIONS=10    # Number of repetitions to run
WORDVECS="wordvecs/GoogleNews-vectors-negative300.bin"

for i in $(seq $REPETITIONS); do
    sbatch ./batchall.sh "$WORDVECS" --test
    sleep $SLEEPTIME
done
