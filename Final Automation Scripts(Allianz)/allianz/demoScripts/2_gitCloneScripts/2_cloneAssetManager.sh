echo "Creating pythonserver directory at /home/cs/allianz/base/ location"
mkdir /home/cs/allianz/base/pythonserver
cd /home/cs/allianz/base/pythonserver
echo "Initializing AssetManager clone"
if git clone  https://github.com/InBetween/AssetManager.git
then
echo "AssetManager clone Successful.."
else
echo "AssetManager clone Failed..Retry" && exit 1
fi
