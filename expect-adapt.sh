#!/usr/bin/expect -f
spawn node install
set timeout -1
expect "This script will install the application. Would you like to continue?"
send "y\r"
expect "(5000)"
send "5000\r";
expect "(localhost)"
send "\r"
expect "(localhost)"
send "\r"
expect "(adapt-tenant-master)"
send "\r"
expect "(27017)"
send "\r"
expect "(data)"
send "\r"
expect "(your-session-secret)"
send "\r"
expect "Will ffmpeg be used?"
send "\r"
expect "supported services.)"
send "\r"
expect "SMTP username"
send "\r"
expect "SMTP password"
#exp_internal 1
send "\r"
expect "Sender email address"
send "\r"
expect "(master)"
send "\r"
expect "(Master)"
send "\r"
set timeout 540
expect "Email address"
send "bravolt\r"
expect "Password"
send "bravolt\r"
expect eof