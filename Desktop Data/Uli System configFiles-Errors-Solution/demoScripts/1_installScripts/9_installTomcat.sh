cd /home/cs/allianz/base/

#######################Download tomcat.tar###########################
echo "Downloading Apache Tomcat..Wait"
if wget http://a.mbbsindia.com/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz
then
echo "Download Successful"
else 
echo "Download Failed..Retry" && exit 1
fi

#######################Extract tomcat.tar###########################
echo "Extracting Tomcat.tar..Wait"
if tar -zxvf apache-tomcat-8.0.33.tar.gz
then
echo "Extraction Successful"
else
echo "Extracxtion failed..Retry" && exit 1
fi

echo "Moving  apache-tomcat-8.0.33 to tomcat"
mv apache-tomcat-8.0.33 tomcat

echo "Operation Successful.."

 
