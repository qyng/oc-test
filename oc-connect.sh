#!/bin/sh
#
# (c) 2018-08-14  Qi Yong <qiy@vecl.cn>
#

prog="openconnect"

if [ -r $HOME/.config/oc-test ]; then
  . $HOME/.config/oc-test
else
  . ./oc-config.conf
fi

if [ -z $username ] || [ -z $server ]; then
  echo "err: $HOME/.config/oc-test is not configured"
  exit 1
fi

inst=0
if [ $1 ]; then
  inst=$1
fi

output=
res=

connect()
{
  output=$(echo -n $password | $prog -u $username --authgroup $group --passwd-on-stdin $server -s ./vpnc-null.sh --authenticate 2> /dev/null)
  res="$?"
}

for t in `seq 0 5`; do
  connect $t
  if [ $res -eq 0 ]; then
    if [ $t -eq 0 ]; then
      echo "inst #$inst-$t \t res: $res"
    else
      echo "inst #$inst-$t \t res: $res \t [success]" > /dev/stderr 
    fi
    break
  else
    if [ $t -eq 0 ]; then
      echo "inst #$inst-$t \t res: $res" > /dev/stderr
    elif [ $t -eq 5 ]; then
      echo "inst #$inst-$t \t res: $res \t [failed]" > /dev/stderr
      break
    fi
  fi
done
