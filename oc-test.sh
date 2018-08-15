#!/bin/sh
#
# (c) 2018-08-14  Qi Yong <qiy@vecl.cn>
#

count=10
if [ $1 ]; then
  count=$1
fi

for i in `seq -w $count`; do
  ./oc-connect.sh $i &
done
