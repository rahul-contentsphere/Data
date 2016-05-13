cd /home/cs/allianz/base/pythonserver/AssetManager

######################Install requirements.txt#########################
echo "Initializing requirements.txt installation"
if pip install -r requirements.txt
then
echo "requirements.txt installed Successfully"
else
echo "requirements.txt installation Failed..Retry" && exit 1
fi

######################Install req.txt#########################
echo "Initializing req.txt installation"
if pip install -r req.txt
then
echo "req.txt installed Successfully "
else 
echo "req.txt installation Failed..Retry" && exit 1
fi

