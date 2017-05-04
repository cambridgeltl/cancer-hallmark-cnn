#!/bin/bash

SLEEPTIME=30    # Seconds to sleep between invoking sbatch
REPETITIONS=1    # Number of repetitions to run
WORDVECS="wordvecs/Chiu-win-2.bin"
MAX_SIZE=10

for r in $(seq $REPETITIONS); do
    # One filter size, 300 filters
    for s in $(seq 1 $MAX_SIZE); do
	sbatch ./batchall.sh "$WORDVECS" --oversample \
	    --filter-sizes $s --filter-nums 300
	sleep $SLEEPTIME
    done

    # Two filter sizes, 150 filters
    for s in $(seq 1 $((MAX_SIZE-1))); do
	sbatch ./batchall.sh "$WORDVECS" --oversample \
	    --filter-sizes $s $((s+1)) --filter-nums 150 150
	sleep $SLEEPTIME
    done

    # Three filter sizes, 100 filters
    for s in $(seq 1 $((MAX_SIZE-2))); do
	sbatch ./batchall.sh "$WORDVECS" --oversample \
	    --filter-sizes $s $((s+1)) $((s+2)) --filter-nums 100 100 100
	sleep $SLEEPTIME
    done

    # Four filter sizes, 75 filters
    for s in $(seq 1 $((MAX_SIZE-3))); do
	sbatch ./batchall.sh "$WORDVECS" --oversample \
	    --filter-sizes $s $((s+1)) $((s+2)) $((s+3)) --filter-nums 75 75 75 75
	sleep $SLEEPTIME
    done

    # Five filter sizes, 60 filters
    for s in $(seq 1 $((MAX_SIZE-4))); do
	sbatch ./batchall.sh "$WORDVECS" --oversample \
	    --filter-sizes $s $((s+1)) $((s+2)) $((s+3)) $((s+4)) --filter-nums 60 60 60 60 60
	sleep $SLEEPTIME
    done
done
