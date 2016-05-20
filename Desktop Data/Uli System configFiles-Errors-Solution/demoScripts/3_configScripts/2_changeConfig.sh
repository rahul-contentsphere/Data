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
echo "log-config.js copied Successfully"
chmod 777 /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/libraries/logger/log-config.js

rm -f /home/cs/allianz/CS-Refactored/Strategy-InMemory/src/main/java/com/cs/base/strategy/inmemory/ElasticCacheImpl.java
cp  -f /home/cs/allianz/applicationConfig/ElasticCacheImpl.java  /home/cs/allianz/CS-Refactored/Strategy-InMemory/src/main/java/com/cs/base/strategy/inmemory/
echo "ElasticCacheImpl.java copied Successfully"
chmod 777 /home/cs/allianz/CS-Refactored/Strategy-InMemory/src/main/java/com/cs/base/strategy/inmemory/ElasticCacheImpl.java


rm -f /home/cs/allianz/CS-Refactored/REST/src/main/webapp/WEB-INF/applicationContext.xml
cp -f /home/cs/allianz/applicationConfig/applicationContext.xml   /home/cs/allianz/CS-Refactored/REST/src/main/webapp/WEB-INF/
echo "applicationContext.xml copied Successfully"
chmod 777 /home/cs/allianz/CS-Refactored/REST/src/main/webapp/WEB-INF/applicationContext.xml


rm -f /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/home-screen-request-mapping.js
cp  -f /home/cs/allianz/applicationConfig/home-screen-request-mapping.js  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/
echo "home-screen-request-mapping.js copied Successfully"
chmod  777 /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/home-screen-request-mapping.js

rm -f /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/asset-authenticate-details.js
cp  -f /home/cs/allianz/applicationConfig/asset-authenticate-details.js  /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/
echo "asset-authenticate-details.js copied Successfully"
chmod  777 /home/cs/allianz/CS-Refactored/REST/src/main/webapp/gui/app/screens/homescreen/tack/asset-authenticate-details.js

cp -f /home/cs/allianz/applicationConfig/uwsgi.ini /home/cs/allianz/base/pythonserver/
echo "uwsgi.ini copied Successfully"
chmod 777 /home/cs/allianz/base/pythonserver/uwsgi.ini

rm /home/cs/allianz/base/pythonserver/AssetManager/swiftAPI/settings.py
cp -f /home/cs/allianz/applicationConfig/settings.py /home/cs/allianz/base/pythonserver/AssetManager/swiftAPI/
echo "settings.py copied Successfully"
chmod 777 /home/cs/allianz/base/pythonserver/AssetManager/swiftAPI/settings.py

cp  /home/cs/allianz/applicationConfig/application-config.js /home/cs/allianz/base/LogServer/scripts/tack/
echo "application-config.js copied Successfully"

cp /home/cs/allianz/applicationConfig/req.txt /home/cs/allianz/base/pythonserver/AssetManager/ 
echo "req.txt copied Successfully"

#gulp webpack
#cd  /home/cs/allianz/CS-Refactored
#./gradlew war

#rm -f /home/cs/allianz/ContentSphereReleases/allianz/etc/dockerfiles/allianz/allianz.war
#cp -f  /home/cs/allianz/CS-Refactored/REST/build/libs/allianz.war  /home/cs/allianz/ContentSphereReleases/allianz/etc/dockerfiles/allianz/

