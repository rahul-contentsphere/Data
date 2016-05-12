cd /home/cs/allianz/base/
########################Download Jetty.tar############################
echo "Downloading jetty-9.2.1.....Wait. "
if wget http://archive.eclipse.org/jetty/9.2.1.v20140609/dist/jetty-distribution-9.2.1.v20140609.tar.gz
then echo "Downloading Jetty Successfull" 
else 
echo " Dlownload failed..Retry" && exit 1
fi

########################Extract Jetty.tar############################
echo "Extracting jetty.tar"
if sudo tar -zxvf jetty-distribution-9.2.1.v20140609.tar.gz
then 
echo "Extraction successful"
else "Extraction Failed..Retry" && exit 1
fi
########################Move jetty-distribution-9.2.1.v20140609 to  jetty############################
mv jetty-distribution-9.2.1.v20140609 jetty
cp /home/cs/allianz/base/jetty/lib/jetty-servlets-9.2.1.v20140609.jar /home/cs/allianz/base/jetty/lib/ext/
