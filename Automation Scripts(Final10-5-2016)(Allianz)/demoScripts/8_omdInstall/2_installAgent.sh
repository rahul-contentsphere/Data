cd /home/cs/allianz/base/

################Download OMD_Agent#####################
echo "Downloading OMD_Agent"
if wget http://mathias-kettner.de/download/check-mk-agent_1.2.4p5-2_all.deb
then
echo "OMD_Agent Downloaded Successfully "
else
echo "OMD_Agent Download Failed..Retry" && exit 1
fi


###################Install OMD_Agent#####################
echo "Installing OMD_Agent"
if dpkg -i check-mk-agent_1.2.4p5-2_all.deb
then
echo "OMD_Agent Installed Successfully"
else
echo "OMD_Agent Installation Failed..Retry" && exit 1
fi
