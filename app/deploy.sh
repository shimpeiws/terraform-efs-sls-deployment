#!/bin/bash
df
ls -l
cd efs
ls -l
export PIPENV_VENV_IN_PROJECT=1
pipenv sync
