#!/bin/bash

HOSTS="angel-a angel-b angel-c"
KILLFIO="ps aux | grep fio | grep -v grep | awk '{print \$2}' | xargs kill -9"

kill_fio()
{
 for i in $HOSTS
   do
   ssh root@$i $KILLFIO
 done

}

mvfs_fio()
{
  for i in $HOSTS
    do
    ssh root@$i "echo angel-$i;export ld_library_path=/opt/memvergedmo/lib;
        nohup /opt/MemVergeDMO/tools/fio --server --alloc-size=1048576  > /dev/null 2>&1  &"
  done
}
reg_fio()
{
  for i in $HOSTS
    do
    ssh root@$i "echo angel-$i;export ld_library_path=/opt/memvergedmo/lib;
        nohup /usr/bin/fio --server --alloc-size=1048576  > /dev/null 2>&1 &"
  done
}

if [[ $1 = kill ]];then
  kill_fio
  exit
fi

if [[ $1 = mvfs ]];then
  mvfs_fio
else
  reg_fio
fi
