#!/bin/bash
yum update -y
yum install -y httpd

echo 'INSTANCE_ID="$(curl http://169.254.169.254/latest/meta-data/instance-id)"
PRIVATE_IP="$(hostname -I)"
PUBLIC_IP="$(curl http://169.254.169.254/latest/meta-data/public-ipv4)"
PUBLIC_HOSTNAME="$(curl http://169.254.169.254/latest/meta-data/public-hostname)"

echo "<h3>Try refreshing the page and see how EC2 data changes!</h3>
<p>Loadbalances to EC2 instance of:
<ul>
		<li><strong>Instance ID</strong>: $INSTANCE_ID</li>
        <li><strong>Private IP</strong>: $PRIVATE_IP</li>
        <li><strong>Public IP</strong>: $PUBLIC_IP</li>
        <li><strong>Public DNS</strong>: $PUBLIC_HOSTNAME</li>
        
</ul></p>" > /var/www/html/index.html' >> /etc/rc.local
chmod +x /etc/rc.local

service httpd start
chkconfig httpd on
