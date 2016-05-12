if cd /home/cs/allianz/base
then
echo "/home/cs/allianz/base Directory Exists"
else
echo "/home/cs/allianz/base Directory does not exist" && exit 1
fi
########################Downloading ElaticSearch#########################
echo "Initializing Installation Of ElasticSearch"
echo "Downloading ElasticSearch 2.1.1.....Wait. "
if wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.1.1/elasticsearch-2.1.1.tar.gz
then
echo "Download Successful.."
else 
echo "Downloading ElasticSearch 2.1.1 Failed..Retry " && exit 1
fi

########################Extracting ElaticSearch.tar#########################
if tar -zxvf elasticsearch-2.1.1.tar.gz
then 
echo "Extraction Successful.."
else
echo "Extraction Failed..Retry" && exit 1
fi

mv elasticsearch-2.1.1 elasticSearch
echo "Moved  elasticsearch-2.1.1 to elasticSearch"
echo "ElasticSearch Installed Successfully"

