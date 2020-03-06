#!/bin/bash

SYNC_DIR='./dev'
TMP_DIR='../tmp-dev'

# devディレクトリのファイルを戻す
echo 'start recovery dev directory...'
if [ "$(ls $TMP_DIR)" ]; then
  mv $TMP_DIR/* $SYNC_DIR
fi
echo 'recover files are as follows:'
ls -l $SYNC_DIR
rmdir $TMP_DIR
echo 'end recovery dev directory.'
