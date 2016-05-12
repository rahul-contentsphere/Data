echo "Initializing Java Installlation"
mkdir /home/cs/allianz
mkdir /home/cs/allianz/base && cd /home/cs/allianz/base/

######################Download JAVA.tar########################
if sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz"
then 
echo "Java Installer Downloaded Successfully"

else echo "Unable to Download JAVA..Retry" && exit 1
fi


######################Extract JAVA.tar########################
echo "Extracting java.tar..Wait"
if sudo tar -zxvf jdk-8u20-linux-x64.tar.gz
then
echo "Extraction Successful.."
else
echo "Extraction Failed..Retry.." && exit 1
fi
######################Configure JAVA ########################
sudo update-alternatives --install /usr/bin/java java /home/cs/allianz/base/jdk1.8.0_20/bin/java 2
#echo "***********  Select 'jdk1.8.0_20' from options ****************"
sudo update-alternatives --config java

######################Set JAVA path########################
export JAVA_HOME=/home/cs/allianz/base/jdk1.8.0_20/bin/java
export JRE_HOME=/home/cs/allianz/base/jdk1.8.0_20/bin/jar
export PATH=$PATH:/home/cs/allianz/base/jdk1.8.0_20/bin:/home/cs/allianz/base/jdk1.8.0_20/bin/jar/bin

######################Display JAVA path andversion to the user########################
echo $PATH
java --version
 
echo "Operation Successful.."
