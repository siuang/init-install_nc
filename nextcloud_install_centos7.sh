yum -y update
service firewalld stop
systemctl disable firewalld.service
setenforce 0
wget https://download.nextcloud.com/server/releases/nextcloud-14.0.4.zip 

yum -y install httpd
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install php70w php70w-mysql unzip
yum -y install php70w-gd php70w-xml php70w-mbstring php70w-ldap php70w-pear php70w-xmlrpc
yum -y install httpd-manual mod_ssl mod_perl mod_auth_mysql

mv nextcloud-14.0.4.zip ~
unzip -d /var/www/  ~/nextcloud-14.0.4.zip
chown apache:apache /var/www/nextcloud -R

systemctl enable httpd.service
service httpd start

touch /etc/httpd/conf.d/nextcloud.conf
echo '<VirtualHost *:80>' >> /etc/httpd/conf.d/nextcloud.conf
echo 'ServerAdmin webmaster@127.0.0.1' >> /etc/httpd/conf.d/nextcloud.conf
echo 'ServerName www.example.com' >> /etc/httpd/conf.d/nextcloud.conf
echo 'DocumentRoot /var/www/nextcloud' >> /etc/httpd/conf.d/nextcloud.conf
echo 'Errorlog logs/nextcloud.error.log' >> /etc/httpd/conf.d/nextcloud.conf
echo 'CustomLog logs/nextcloud.access.log combine' >> /etc/httpd/conf.d/nextcloud.conf
echo '</VirtualHost>' >> /etc/httpd/conf.d/nextcloud.conf


service httpd reload
