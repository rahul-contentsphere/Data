cd /home/cs/allianz/
echo "Initializing CS-Refactored Clone"
if git clone https://reader-inbetween:pass%40123@github.com/Inbetween/CS-Refactored.git
then
echo "CS-Refactored Clone Successful"
else
echo "CS-Refactored Clone Failed..Retry" && exit 1
fi
