cd /home/cs/allianz/base/
echo "Downloading jetty-9.2.1.....Wait. "
wget http://archive.eclipse.org/jetty/9.2.1.v20140609/dist/jetty-distribution-9.2.1.v20140609.tar.gz
sudo tar -zxvf jetty-distribution-9.2.1.v20140609.tar.gz
mv jetty-distribution-9.2.1.v20140609 jetty
cp /home/cs/allianz/base/jetty/lib/jetty-servlets-9.2.1.v20140609.jar /home/cs/allianz/base/jetty/lib/ext/
