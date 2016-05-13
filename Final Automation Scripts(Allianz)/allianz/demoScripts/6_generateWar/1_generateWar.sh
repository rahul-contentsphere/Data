cd  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui
chmod -R 777 /home/cs/allianz
echo "Permissions Changed to 777 of /home/cs/allianz"
########################## npm install############################
echo "Initializing npm install at /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui location"
if npm install
then
echo "npm Installation Successful"
else
echo "npm Installation Failed..Retry" && exit 1
fi

########################## npm install -g gulp############################
echo "Initializing npm install -g gulp at /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui location"
if npm install -g gulp
then
echo " npm install -g gulp Successful"
else
echo " npm install -g gulp Failed..Retry" && exit 1
fi

########################## gulp webpack############################
cd  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/appconfig
if gulp webpack
then
echo "gulp webpack Successful"
else
echo "gulp webpack Failed..Retry" && exit 1
fi

########################## generate war############################
cd  /home/cs/allianz/CS-Refactored
chmod 777 gradlew
echo "Initializing ./gradlew war at /home/cs/allianz/CS-Refactored location"
if ./gradlew war
then
echo "War generated Successfully"
else
echo "War generation Failed..Retry" && exit 1
fi
###################remove and copy war##############################
rm -f /home/cs/allianz/base/jetty/webapps/allianz.war
cp -f  /home/cs/allianz/CS-Refactored/REST/build/libs/allianz.war  /home/cs/allianz/base/jetty/webapps
echo "allianz.war copied to /home/cs/allianz/base/jetty/webapps successfully"
echo "Opearation Successful"

