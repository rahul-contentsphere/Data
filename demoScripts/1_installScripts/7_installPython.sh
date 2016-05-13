apt-get update &&  apt-get install -y  python-pip
apt-get install -y python-dev
apt-get -y build-dep python-imaging
pip install  uwsgi
apt-get build-dep python-imaging
apt-get -y install libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev
pip install Pillow
pip install django
pip install  djangorestframework
pip install python-swiftclient
pip install django-cors-headers

