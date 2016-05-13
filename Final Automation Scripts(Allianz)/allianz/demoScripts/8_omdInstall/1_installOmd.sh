cd /home/cs/allianz/base/

apt-get update 
apt-get upgrade

echo "Downloading OMD"
if wget http://files.omdistro.org/releases/debian_ubuntu/omd-1.20.trusty.amd64.deb
then
echo "Download Succesful"
else
echo "Download Failed..Retry" && exit 1
fi

echo "installing OMD"
dpkg -i omd-1.20.trusty.amd64.deb
apt-get -f install -y
