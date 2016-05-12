#######################Install GIT
echo "Initializing GIT Installation"
if apt-get install git -y
then 
echo " Installation Successful"
else "Installation Failed..Retry" && exit 1
fi

echo "configuring username & email"
git config --global user.email "inbetween@contentsphere.com"
git config --global user.name "inbetween"
echo "Configuring username & email successfull"
