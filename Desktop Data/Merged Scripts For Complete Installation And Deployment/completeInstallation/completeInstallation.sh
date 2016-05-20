###############Install Java
if [ ! -e `which java` ]; 
then
    /home/cs/demoScripts/1_installScripts/1_installJava.sh
else
    echo "Java already installed" && exit 1
###############Install ElasticSearch
/home/cs/demoScripts/1_installScripts/2_installElasticSearch.sh

###############Install Neo4J
/home/cs/demoScripts/1_installScripts/3_installNeo4jEnterprise.sh

###############Install Git
/home/cs/demoScripts/1_installScripts/4_installGit.sh

###############Install Jetty
/home/cs/demoScripts/1_installScripts/5_installJetty.sh

###############Install Nodejs
/home/cs/demoScripts/1_installScripts/6_installNodejs.sh

###############Instasll Python
/home/cs/demoScripts/1_installScripts/7_installPython.sh

###############Install PythonServer Requirements
/home/cs/demoScripts/1_installScripts/8_installPythonRelated.sh

###############Install Tomcat
/home/cs/demoScripts/1_installScripts/9_installTomcat.sh

###############Install PythonServer Requirements
/home/cs/demoScripts/1_installScripts/10_installPythonRelated.sh


