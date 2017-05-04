#!/bin/bash

#SBATCH -A COLLIER-SL3-GPU
#SBATCH -p tesla
#SBATCH -n 1
#SBATCH -t 60

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 WORDVECS [ARGS]" >&2
    exit 1
fi

WORDVECS="$1"
shift

BASEDIR="${HOME}/git_checkout/hallmark-cnn"
SCRIPTDIR="${BASEDIR}/keras/"
CNN="${SCRIPTDIR}/cnn.py"
DATADIR="${BASEDIR}/data/doc-10-class"

PARAMS="$@ --verbosity 0"

. /etc/profile.d/modules.sh
module purge
module load default-wilkes
module unload cuda
module load cuda/7.5 python/2.7.5
module load cudnn/4.0_cuda-7.5

. $HOME/env/tensorflow-0.9/bin/activate

export THEANO_FLAGS='mode=FAST_RUN,device=gpu,floatX=float32'

for d in "$DATADIR"/label-*; do
    python "$CNN" $PARAMS "$d" "$WORDVECS"
done
