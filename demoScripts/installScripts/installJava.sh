#apt-get install -y default-jre
#apt-get install -y default-jre-headless

mkdir /home/cs/allianz/base
#chmod -R 777 /opt
cd /home/cs/allianz/base

sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz"

sudo tar -zxvf jdk-8u20-linux-x64.tar.gz
sudo update-alternatives --install /usr/bin/java java /home/cs/allianz/base/jdk1.8.0_20/bin/java 2
echo "***********  Select 'jdk1.8.0_20' from options ****************"
sudo update-alternatives --config java

export JAVA_HOME=/home/cs/allianz/base/jdk1.8.0_20/bin/java

export JRE_HOME=/home/cs/allianz/base/jdk1.8.0_20/bin/jar

export PATH=$PATH:/home/cs/allianz/base/jdk1.8.0_20/bin:/home/cs/allianz/base/jdk1.8.0_20/bin/jar/bin

