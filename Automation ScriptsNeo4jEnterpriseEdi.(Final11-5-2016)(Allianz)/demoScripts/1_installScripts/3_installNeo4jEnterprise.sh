########################Download neo4j.tar#############################
cd /home/cs/allianz/base/
########################Extraction of  neo4j.tar#############################
if tar -zxvf neo4j-enterprise-2.3.2-unix.tar.gz
then
echo "Extraction Successful"
else
echo "Extraction Failed..Retry" && exit 1
fi

echo "Operation Successful"

