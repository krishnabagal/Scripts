#=============================================================#
# You need to update FTP user name and password in CISCO SW
# eg.
# > conf t
# > ip ftp username <username>
# > ip ftp password <password>
# > exit
# > wr mem
#=============================================================#
#!/usr/bin/expect
spawn ssh -o StrictHostKeyChecking=no -l <USERNAME> <SW-IP>
expect "Password:"
send "<PASSWORD>\n"
expect ">"
send "en\n"
expect "Password:"
send "<EN-PASSWORD>\n"

send "copy running-config ftp://<FTP-SERVER-IP>/<BACKUP-DIR>/\n\n"
expect "]?"
send "\n"
expect "]?"
send "\n"
send "exit\n"
