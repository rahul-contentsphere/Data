cd  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui
npm install
npm install -g gulp

cd  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/appconfig
gulp webpack

cd  /home/cs/allianz/CS-Refactored
chmod 777 gradlew
./gradlew war

rm -f /home/cs/allianz/base/jetty/webapps/allianz.war
cp -f  /home/cs/allianz/CS-Refactored/REST/build/libs/allianz.war  /home/cs/allianz/base/jetty/webapps

