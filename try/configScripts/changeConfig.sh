#cd /home/cs/allianz/CS-Refactored
#git config core.filemode false
#chmod -R 777 /home/cs/allianz/CS-Refactored
#cd  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui
#npm install
#npm install -g gulp
#npm rebuild node-sass
#cd  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/appconfig

rm -f /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/libraries/logger/log-config.js
cp  -f /home/cs/allianz/applicationConfig/log-config.js /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/libraries/logger/
chmod 777 /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/libraries/logger/log-config.js

rm -f /home/cs/allianz/CS-Refactored/Strategy-InMemory/src/main/java/com/cs/base/strategy/inmemory/ElasticCacheImpl.java
cp  -f /home/cs/allianz/applicationConfig/config.d/ElasticCacheImpl.java  /home/cs/allianz/CS-Refactored/Strategy-InMemory/src/main/java/com/cs/base/strategy/inmemory/
chmod 777 /home/cs/allianz/CS-Refactored/Strategy-InMemory/src/main/java/com/cs/base/strategy/inmemory/ElasticCacheImpl.java


rm -f /home/cs/allianz/CS-Refactored/REST/src/main/webapp/WEB-INF/applicationContext.xml
cp -f /home/cs/allianz/applicationConfig/applicationContext.xml   /home/cs/allianz/CS-Refactored/REST/src/main/webapp/WEB-INF/
chmod 777 /home/cs/allianz/CS-Refactored/REST/src/main/webapp/WEB-INF/applicationContext.xml


rm -f /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/home-screen-request-mapping.js
cp  -f /home/cs/allianz/applicationConfig/home-screen-request-mapping.js  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/
chmod  777 /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/home-screen-request-mapping.js

rm -f /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/asset-authenticate-details.js
cp  -f /home/cs/allianz/applicationConfig/asset-authenticate-details.js  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/
chmod  777 /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/asset-authenticate-details.js

#gulp webpack
#cd  /home/cs/allianz/CS-Refactored
#./gradlew war

#rm -f /home/cs/allianz/ContentSphereReleases/allianz/etc/dockerfiles/allianz/allianz.war
#cp -f  /home/cs/allianz/CS-Refactored/REST/build/libs/allianz.war  /home/cs/allianz/ContentSphereReleases/allianz/etc/dockerfiles/allianz/

