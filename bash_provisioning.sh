#!/bin/bash

# update and install jre, apache, xvfb, unzip, firefox, git, pip, selenium, holmium and nose
apt-get update -y
apt-get install openjdk-7-jre -y
apt-get install apache2 -y
apt-get install xvfb -y
apt-get install xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic
apt-get install unzip -y
apt-get install firefox -y
apt-get install git-core -y
apt-get install python-pip -y
pip install -U selenium
pip install -U holmium.core
easy_install nose
pip install nosedbreport

# install chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
apt-get update
apt-get install google-chrome-stable -y

# install chromedriver
wget http://chromedriver.googlecode.com/files/chromedriver_linux64_26.0.1383.0.zip
unzip chromedriver_linux64_26.0.1383.0.zip
rm chromedriver_linux64_26.0.1383.0.zip
mv chromedriver /usr/local/bin

# get selenium server
wget "https://selenium.googlecode.com/files/selenium-server-standalone-2.31.0.jar" -O ~/selenium-server.jar
