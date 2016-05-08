cd  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui
npm install
npm install -g gulp

cd  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/appconfig
gulp webpack

cd  /home/cs/allianz/CS-Refactored
./gradlew war

rm -f /home/cs/allianz/ContentSphereReleases/allianz/etc/dockerfiles/allianz/allianz.war
cp -f  /home/cs/allianz/CS-Refactored/REST/build/libs/allianz.war  /home/cs/allianz/ContentSphereReleases/allianz/etc/dockerfiles/allianz/

