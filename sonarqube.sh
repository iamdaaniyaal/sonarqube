sudo systemctl stop firewalld && sudo systemctl disable firewalld
sudo yum install java-1.8.0-openjdk  java-1.8.0-openjdk-devel -y
sudo yum install http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm -y
sudo yum install mysql-server  expect  wget  unzip  -y
sudo systemctl start mysqld && systemctl enable  mysqld  && sudo cd /devops/
sudo chmod 777 /devops/* 
sudo sh /devops/mysqlroot_passwdreset 
sudo sh /devops/mysqlcreate_db_user --host=localhost --database=sonardb --user=sonaruser < /devops/mysqlroot_passwd
sudo wget -P /opt   https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-6.0.zip
sudo unzip /opt/sonarqube-6.0.zip -d /opt &&  sudo mv /opt/sonarqube-6.0  /opt/sonarqube
sudo mv /opt/sonarqube/conf/sonar.properties /mnt/  && sudo cat /devops/mysonar.properties >> /opt/sonarqube/conf/sonar.properties
sudo sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start
