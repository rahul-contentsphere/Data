cd /home/cs/allianz/base/
echo "Initializing LogServer clone"
if git clone  https://github.com/tauseef-inbetween/LogServer
then
echo "LogServer clone Successful"
else
echo "LogServer clone Failed..Retry" && exit 1
fi
#################npm install##########################
cd /home/cs/allianz/base/LogServer
echo "npm install in progress.."
if npm install
then 
echo "npm install Successful"
else
echo "npm install Failed..Retry" && exit 1
fi
