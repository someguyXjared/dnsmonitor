#!/bin/bash
# monitor.sh - Monitors a DNS records for changes
# Manually add and remove records
# sends an email notification if the file change
# 
# Mainly used for private/personal domains that require FW ACLs,
# that require updating of IP address


USERNAME="youremail@gmail.com"
PASSWORD="password"
TLD="google.com"
DNS1="docs.$TLD"
DNS2="drive.$TLD"
DNS3="mail.$TLD"
DNS4="smtp.$TLD"
DNS5="voice.$TLD" 
DNS6="account.$TLD"
touch new.$TLD.txt
for (( ; ; )); do
    mv new.$TLD.txt old.$TLD.txt 2> /dev/null
    dig $DNS1 +nottlid | grep $DNS1 >> new.$TLD.txt
    dig $DNS2 +nottlid | grep $DNS2 >> new.$TLD.txt
    dig $DNS3 +nottlid | grep $DNS3 >> new.$TLD.txt
    dig $DNS4 +nottlid | grep $DNS4 >> new.$TLD.txt
    dig $DNS5 +nottlid | grep $DNS5 >> new.$TLD.txt
    dig $DNS6 +nottlid | grep $DNS6 >> new.$TLD.txt
    DIFF_OUTPUT="$(diff new.$TLD.txt old.$TLD.txt)"
    if [ "0" = "${#DIFF_OUTPUT}" ]; then
        dt=$(date)
        echo "No Change $dt" >> $TLD.log
        sleep 600 # wait X seconds
    fi
    if [ "0" != "${#DIFF_OUTPUT}" ]; then
        dt=$(date)
        sendEmail -f $USERNAME -s smtp.gmail.com:587 \
            -xu $USERNAME -xp $PASSWORD -t $USERNAME \
            -o tls=yes -u "DNS changed" \
            -m "Visit it at  and the difference is $DIFF_OUTPUT" \
            -a new.$TLD.txt old.$TLD.txt
        echo "Email sent $dt to $USERNAME" >> $TLD.log
        sleep 600 # wait X seconds
    fi
done
