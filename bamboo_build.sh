#!/bin/bash

type module >& /dev/null || . /mnt/software/Modules/current/init/bash
module purge
module load git
module load gcc
module load ccache
module load python/2
#module load make

set -vex
git --version
which gcc
which g++
gcc --version
which python

rm -rf LOCAL
mkdir -p LOCAL
export PYTHONUSERBASE=$(pwd)/LOCAL
export PATH=${PYTHONUSERBASE}/bin:${PATH}
WHEELHOUSE="/mnt/software/p/python/wheelhouse/develop/"

#pip install --user --no-index --find-links=${WHEELHOUSE} pypeflow
#
## Unfortunately, we need pypeflow for pylint.
#python -c 'import pypeflow as p; print p'
#python -c 'import pypeflow.sample_tasks as p; print p'

export WHEELHOUSE
make install-edit
# Note: no --edit because we might be building artifacts.
# ... Scratch that. We have trouble getting coverage for
#  source=falcon_kit
# but maybe it will work with a --edit install.

export MY_TEST_FLAGS="-v -s --durations=0 --cov=falcon_kit --cov-report=term-missing --cov-report=xml:coverage.xml --cov-branch"
make test

make pylint

bash bamboo_wheel.sh
