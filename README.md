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

* We need
    * [Java Runtime Environment](http://openjdk.java.net/install/)
    * [Apache](https://help.ubuntu.com/lts/serverguide/httpd.html)
    * [XVFB](http://www.x.org/archive/X11R7.6/doc/man/man1/Xvfb.1.xhtml)
    * [Selenium](http://www.seleniumhq.org)
    * [Firefox](https://support.mozilla.org/si/kb/Linux%20මත%20ෆයර්ෆොක්ස්%20ස්ථාපනය)
    * [Chrome (Driver)](https://code.google.com/p/selenium/wiki/ChromeDriver)

* Ubuntu

        cd && \
        sudo apt-get update && \
        sudo apt-get install openjdk-8-jre && \
        sudo apt-get install apache2 && \
        sudo apt-get install xvfb && \
        mkdir selenium-server && cd selenium-server
        wget "https://selenium.googlecode.com/files/selenium-server-standalone-2.47.1.jar" && \
        cd && \
        sudo apt-get install firefox && \
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
        sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
        sudo apt-get update && \
        sudo apt-get install google-chrome-stable && \
        wget http://chromedriver.storage.googleapis.com/2.19/chromedriver_linux32.zip && \
        sudo apt-get install unzip && \
        unzip chromedriver_linux*.zip && \
        rm chromedriver_linux*.zip && \
        sudo mv chromedriver /usr/local/bin

* Red Hat

        cd && \
        sudo yum update && \
        su -c "yum install java-1.8.0-openjdk" && \
        sudo yum install httpd && \
        sudo yum install xorg-x11-server-Xvfb && \
        mkdir selenium-server && cd selenium-server
        wget "https://selenium.googlecode.com/files/selenium-server-standalone-2.47.1.jar" && \
        cd && \
        sudo yum install firefox && \
        cat << EOF > /etc/yum.repos.d/google-chrome.repo
        [google-chrome]
        name=google-chrome - \$basearch
        baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
        enabled=1
        gpgcheck=1
        gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
        EOF
        yum install google-chrome-stable
        wget http://chromedriver.storage.googleapis.com/2.19/chromedriver_linux32.zip && \
        unzip chromedriver_linux*.zip && \
        rm chromedriver_linux*.zip && \
        sudo mv chromedriver /usr/local/bin

Launch XVFB and Selenium
------------------------

* Ubuntu

        nohup Xvfb :0 -screen 0 1024x768x24 2>&1 >/dev/null &
        export DISPLAY=:0
        nohup java -jar ~/selenium-server/selenium-server-standalone-2.47.1.jar & > selenium.log &

* Red Hat

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
