#!/bin/bash
ls -l
mount -t efs fs-XXXXXX.efs.ap-northeast-1.amazonaws.com:/ efs
cd efs
export PIPENV_VENV_IN_PROJECT=1
pipenv sync
