echo "Installation Initialized.."
################# install python-pip
if apt-get update &&  apt-get install -y  python-pip
then
echo "Proceeding to next installation"
else
echo "1st Module Installation Failed..Retry" && exit 1
fi

################# install python-dev
if apt-get install -y python-dev
then
echo "Proceeding to next installation"
else
echo "2nd Module Installation Failed..Retry" && exit 1
fi


################# install python-imaging
if apt-get -y build-dep python-imaging
then
echo "Proceeding to next installation"
else
echo "3rd Module Installation Failed..Retry" && exit 1
fi


################# install uwsgi
if pip install  uwsgi
then
echo "Proceeding to next installation"
else
echo "4th Module Installation Failed..Retry" && exit 1
fi


################# install  python-imaging
if apt-get build-dep python-imaging
then
echo "Proceeding to next installation"
else
echo "5th Module Installation Failed..Retry" && exit 1
fi


################# install libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev
if apt-get -y install libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev
then
echo "Proceeding to next installation"
else
echo "6th Module Installation Failed..Retry" && exit 1
fi


################# install Pillow
if pip install Pillow
then
echo "Proceeding to next installation"
else
echo "7th Module Installation Failed..Retry" && exit 1
fi



################# install django
if pip install django
then
echo "Proceeding to next installation"
else
echo "8th Module Installation Failed..Retry" && exit 1
fi



################# djangorestframework
if pip install  djangorestframework
then
echo "Proceeding to next installation"
else
echo "9th Module Installation Failed..Retry" && exit 1
fi



################# install python-swiftclient
if pip install python-swiftclient
then
echo "Proceeding to next installation"
else
echo "10th Module Installation Failed..Retry" && exit 1
fi



################# install django-cors-headers
if pip install django-cors-headers
then
echo "Complete Installation Successful"
else
echo "Last Module Installation Failed..Retry" && exit 1
fi

