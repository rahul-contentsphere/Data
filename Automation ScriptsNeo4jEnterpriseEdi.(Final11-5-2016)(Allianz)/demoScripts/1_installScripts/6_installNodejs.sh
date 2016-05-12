echo "Initializing NodeJs Installation"
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -


#################Install Nodejs
echo "Installing nodejs"
if sudo apt-get -y install nodejs --force-yes
then
echo "nodejs Installed Successfully"
else
echo "nodejs Installation Failed..Retry" && exit 1
fi



#############Install forever to run nodejs in background
echo "Installing forever"
if npm -g install forever 
then
echo "forever Installed Successfully.."
else 
echo "forever Installation Failed..Retry.." && exit 1
fi

echo "Operation Successful.."

