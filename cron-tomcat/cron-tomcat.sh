{
#!/bin/bash
cat <<'EOF'> /usr/local/bin/cron-tomcat.sh
echo "Only running this script on Tomcat servers. Checking.."
if [ ! -f /opt/tomcat/bin/startup.sh ]; then 
	exit 1
fi
TOMCAT=$(ps -ef | grep java | grep tomcat | wc -l )
if [ ${TOMCAT} -eq 0 ]; then
        echo "Tomcat is not running, starting it!"
        pkill -9 java
        sudo -i -u tomcat /opt/tomcat/bin/startup.sh
        echo "This email is informational. Tomcat was restarted on `hostname -f` by cron!" | mail -s "Tomcat restarted on `hostname` -f!" youremail@email.com 
else
        echo "Tomcat is running, nothing to do"
        exit 1
fi
EOF
chmod 700 /usr/local/bin/cron-tomcat.sh

cat <<'EOF'> /etc/cron.d/cron-tomcat
*/5 * * * * root /usr/local/bin/cron-tomcat.sh > /dev/null 2>&1
EOF
}
