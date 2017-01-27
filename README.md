Setup Selenium Server
=====================

Setup Machine
-------------

* Local Machine

    I prefer ubuntu so these instructions are to make it publicly (and somewhat safely) accessible from the internet
    * Install [OpenSSH Server](https://help.ubuntu.com/lts/serverguide/openssh-server.html)
    * [Disable Password Authentication](https://help.ubuntu.com/community/SSH/OpenSSH/Configuring)
    * [Add your public key](http://askubuntu.com/questions/46424/adding-ssh-keys-to-authorized-keys)
    * [Forward Port 22 on your router](http://i.imgur.com/iEUc4Jm.png)
    * [Sign up for a noip account](http://www.noip.com)
        * Create a hostname
        * [Install Ubuntu client](http://www.noip.com/support/knowledgebase/installing-the-linux-dynamic-update-client-on-ubuntu/)
        * Setup client
    * Now you can ssh from the internet like `ssh sajnikanth@sajnikanth.ddns.net`
        * Note - you cannot test this from within LAN. You have to use local ip

* EC2
    * [Security Group](http://i.imgur.com/Pg1yIsy.png)
        * 4444 is required to serve selenium
    * Spin up a new instance

Install
-------

### [Java Runtime Environment](http://openjdk.java.net/install/)

Ubuntu

        cd && \
        sudo apt-get update -y && \
        sudo apt-get install openjdk-8-jre -y

Amazon Linux

        cd && \
        sudo yum update -y && \
        sudo yum install java-1.8.0-openjdk -y

### [Apache](https://help.ubuntu.com/lts/serverguide/httpd.html)

Ubuntu

        sudo apt-get install apache2 -y

Amazon Linux

        sudo yum install httpd -y

### [XVFB](http://www.x.org/archive/X11R7.6/doc/man/man1/Xvfb.1.xhtml)

Ubuntu

        sudo apt-get install xvfb -y

Amazon Linux

        sudo yum install xorg-x11-server-Xvfb -y

### [Selenium](http://www.seleniumhq.org)

        mkdir selenium-server && cd selenium-server && \
        wget "wget https://goo.gl/Lyo36k -O selenium-server-standalone.jar" && \
        cd

### [Firefox](https://support.mozilla.org/si/kb/Linux%20මත%20ෆයර්ෆොක්ස්%20ස්ථාපනය)

Ubuntu

        sudo apt-get install firefox -y

Amzon Linux (Takes a while; comment out line 69 if required)

        wget https://gist.githubusercontent.com/joekiller/4144838/raw/ffd5fabce7083eca65c61033ea90e51b4be6ba55/gtk-firefox.sh
        chmod +x gtk-firefox.sh
        sudo ./gtk-firefox.sh

### [Chrome (Driver)](https://code.google.com/p/selenium/wiki/ChromeDriver)

Ubuntu

        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
        sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
        sudo apt-get update -y && \
        sudo apt-get install google-chrome-stable -y && \
        wget http://chromedriver.storage.googleapis.com/2.19/chromedriver_linux32.zip && \
        sudo apt-get install unzip -y && \
        unzip chromedriver_linux*.zip && \
        rm chromedriver_linux*.zip && \
        sudo mv chromedriver /usr/local/bin

Launch Apache, XVFB and Selenium
--------------------------------

* Ubuntu

        sudo /etc/init.d/apache2 restart
        nohup Xvfb :0 -screen 0 1024x768x24 2>&1 >/dev/null &
        export DISPLAY=:0
        nohup java -jar ~/selenium-server/selenium-server-standalone*.jar & > selenium.log &

* Amazon Linux

        sudo /sbin/service httpd restart
        rm nohup.out
        nohup Xvfb :1 -screen 0 1024x768x24 & >/dev/null
        # if you have issues, sudo rm /usr/local/lib/libpixman-1.so.0

Check
-----

* From local

        curl "http://localhost:4444/wd/hub/status"

* From the intenet (will not work from LAN)

        curl "http://sajnikanth.ddns.net:4444/wd/hub/status"

Use
---

* When using holmium

        --holmium-remote=http://sajnikanth.ddns.net:4444/wd/hub/
