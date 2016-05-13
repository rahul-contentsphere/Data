apt-get update -qq && apt-get install -y
apt-get update && apt-get install -y ghostscript
apt-get install -y libgs-dev
apt-get install imagemagick
cd /home/cs/allianz/base/
wget http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.15.tar.gz
tar -xvf Image-ExifTool-10.15.tar.gz
cd Image-ExifTool-10.15/
perl Makefile.PL
make test
sudo make install

