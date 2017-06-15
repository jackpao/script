#!/usr/bin/python
"""

Python code to remotely ssh connect to a host, and return 
command output

"""



from subprocess import PIPE,Popen

HOST="10.1.132.93"
# Ports are handled in ~/.ssh/config since we use OpenSSH
COMMAND="ssh  nutanix@10.1.132.93 ps axf |grep python |wc -l"



A = "10.1.132."
Host_list = []

fail_list = []

for i in xrange(92,96):
  Host_list.append(A + str(i))


print Host_list

for i in Host_list:
  print i

  output = Popen(['ssh', i, 'ps axf|grep python|wc -l'],stdout=PIPE)
  
  #command output
  out = output.communicate()[0]

  print "out check"
  print out
  if int(out) >= 35:
    print "check done"
    print i
  else:
    print "check if fail"
    fail_list.append(i)

print fail_list

