echo "Before Cleaning the files..!"
du  /var/cache/apt/archives

sudo apt-get clean
echo "After Cleaning the files..!"
du  /var/cache/apt/archives

