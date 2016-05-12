########################Download neo4j.tar#############################
cd /home/cs/allianz/base/
echo "Downloading Neo4j....Wait."
if wget http://neo4j.com/artifact.php?name=neo4j-community-2.3.3-unix.tar.gz 
then 
echo " Download Successful"
else
echo "Downloading Neo4j Failed..Retry" && exit 1
fi
########################Extraction of  neo4j.tar#############################
if tar -zxvf artifact.php?name=neo4j-community-2.3.3-unix.tar.gz
then
echo "Extraction Successful"
else
echo "Extraction Failed..Retry" && exit 1
fi

########################move neo4j-community-2.3.3 to  neo4j#############################
mv neo4j-community-2.3.3 neo4j
echo "Moved  neo4j-community-2.3.3 to neo4j "
echo "Operation Successful"

