#!/usr/local/bin/expect -f



spawn sudo -s

expect "zengcj 的密码:"

send "********\r"

 

expect "*#*"

send "docker restart tomcat8081\r"
#......#
 

expect "*#*"

send "exit\r"