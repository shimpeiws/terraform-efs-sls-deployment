#!/bin/bash
df
pwd
ls -l

cd efs
pwd
ls -l

cp ../Pipfile Pipfile
cp ../Pipfile.lock Pipfile.lock

HASH=`shasum -a 256 ../Pipfile.lock |  awk '{print $1}'`
echo $HASH

if [ -d ${HASH} ]; then
  echo "Folder already exists"
else
  mkdir $HASH
  cd $HASH
  cp ../Pipfile Pipfile
  cp ../Pipfile.lock Pipfile.lock
  export PIPENV_VENV_IN_PROJECT=1
  pipenv sync
fi
