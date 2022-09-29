#!/bin/bash
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -i amazon-cloudwatch-agent.rpm
echo "Installation wizard will be starting now"
sleep 1
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
echo "Log files configured"
sleep 1
echo "Config file will be fetched now"
sleep 2
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
echo "Agent starting"
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
echo "Agent status"
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status
echo "If you see any parsing error press y otherwise you might exit anytime"
read answer
if [ $answer == "y" ]; then
 sudo mkdir /usr/share/collectd
 cd /usr/share/collectd
 sudo touch types.db
else
 echo "Exited"
fi