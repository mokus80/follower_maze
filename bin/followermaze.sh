#! /bin/bash

SEED=666
EVENTS=10
CONCURRENCY=10

time java -server -Xmx1G -jar bin/follower-maze-2.0.jar $SEED $EVENTS $CONCURRENCY

#time java -server -XX:-UseConcMarkSweepGC -Xmx2G -jar bin/FollowerMaze-assembly-1.0.jar $SEED $EVENTS $CONCURRENCY
