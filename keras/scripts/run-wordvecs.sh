#!/bin/bash

SLEEPTIME=30    # Seconds to sleep between invoking sbatch
REPETITIONS=10    # Number of repetitions to run
WVDIR="wordvecs"

for i in $(seq $REPETITIONS); do
    for v in "$WVDIR"/*.bin; do
	sbatch ./batchall.sh "$v" --oversample 
	sleep $SLEEPTIME
    done
done
