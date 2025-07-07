#!/bin/bash
trap "echo Caught SIGTERM" TERM
sleep 60
