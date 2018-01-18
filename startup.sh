#!/usr/bin/env bash
set -e

LOCUST_BIN="/usr/local/bin/locust"

if [[ -z  "$LOCUST_MODE" ]]; then
  echo "LOCUST_MODE must be defined."
  exit -1;
fi

if [[ "$LOCUST_MODE" = "master" ]]; then
  ARGS="$ARGS --master"
elif [[ "$LOCUST_MODE" = "slave" ]]; then
  if [[ ! -n "$LOCUST_MASTER" ]]; then
    echo "if LOCUST_MODE is slave LOCUST_MASTER must be defined"
    exit -1
  fi

  ARGS="$ARGS --slave --master-host=$LOCUST_MASTER"
fi

if [[ -n "$LOCUST_REMOTE_ARCHIVE" ]]; then
  echo "Downloading $LOCUST_REMOTE_ARCHIVE"
  curl -L $LOCUST_REMOTE_ARCHIVE -o /locust.tgz

  mkdir /locust
  cd /locust
  tar -zxvf /locust.tgz
fi

if [[ -n "$LOCUST_TARGET_HOST" ]]; then
  ARGS="$ARGS --host=$LOCUST_TARGET_HOST"
fi

if [[ -n "$LOCUST_TASKFILE" ]]; then
  if [[ -f $LOCUST_TASKFILE ]]; then
    echo "using $LOCUST_TASKFILE for tasks"
    ARGS="$ARGS -f $LOCUST_TASKFILE"
  else
    echo "LOCUST_TASKFILE($LOCUST_TASKFILE) defined but does not exist"
    exit -1
  fi
else
  echo "LOCUST_TASKFILE must be defined"
  exit -1
fi

if [[ -f /locust/requirements.txt ]]; then
  echo "Python requirements.txt found, installing pre-reqs"
  pip install -r /locust/requirements.txt
fi

echo "startup string: $LOCUST_BIN $ARGS"

$LOCUST_BIN $ARGS
