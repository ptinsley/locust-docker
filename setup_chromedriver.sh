set -e
cd /tmp

#get prereqs in place
apt update
apt install -y \
  unzip \
  libnss3 \
  xvfb \
  libxss1 \
  libappindicator1 \
  libindicator7 \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libgtk-3-0 \
  libxtst6 \
  lsb-release \
  xdg-utils

#install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome*.deb

#install chromedriver
wget -NL https://chromedriver.storage.googleapis.com/2.38/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
chmod +x chromedriver
mv chromedriver /usr/local/bin/