set -e
apt update && apt install unzip libnss3
cd /tmp
wget -NL https://chromedriver.storage.googleapis.com/2.38/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
chmod +x chromedriver
mv chromedriver /usr/local/bin/