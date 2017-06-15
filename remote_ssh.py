#!/usr/bin/python
from subprocess import PIPE,Popen

HOST="10.1.132.93"
# Ports are handled in ~/.ssh/config since we use OpenSSH
COMMAND="ssh  nutanix@10.1.132.93 ps axf |grep python |wc -l"


output = Popen(['ssh', HOST, 'ps axf|grep python|wc -l'],stdout=PIPE)

out = output.communicate()[0]

print "out check"
print out
if out >= 30:
  print "check done"
  print out
else:
  print "check if fail"


