#################Update

echo "Update in Progress"
if apt-get update -qq && apt-get install -y
then
echo "Update Successful.."
else
echo "Update Failed..Retry" && exit 1
fi


#################Install ghostscript
echo "Installing  ghostscript.."
if apt-get update && apt-get install -y ghostscript
then
echo "Installation Successful.."
else
echo "Installation Failed..Retry" && exit 1
fi


#################Install libgs-dev
echo "Installing libgs-dev.."
if apt-get install -y libgs-dev
then
echo "Installation Successful.."
else
echo "Installation Failed..Retry" && exit 1
fi



#################Install imagemagick
echo "Installing imagemagick.."
if apt-get install imagemagick -y 
then
echo "Installation Successful.."
else
echo "Installation Failed..Retry" && exit 1
fi


cd /home/cs/allianz/base/
#################Download Image-ExifTool##########################
echo "Downloading Image-ExifTool.."
if wget http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.15.tar.gz
then 
echo "Download Successful.."
else
echo "Download Failed..Retry" && exit 1
fi

#################Extract Image-ExifTool.tar##########################
echo "Extracting Image-ExifTool-10.15.tar.gz"
if tar -xvf Image-ExifTool-10.15.tar.gz
then
echo "Extraction Successful.."
else
echo "Extraction Failed..Retry" && exit 1
fi

#################Install Image-ExifTool##########################
echo "Installation in Progress.."
cd Image-ExifTool-10.15/
perl Makefile.PL
make test
sudo make install
echo "Installation Successful.."

