About
=====

Script to setup a remote selenium server on ubuntu

Setup
=====
* Run `bash_provisioning.sh`. It can also be used as an ec2 data file
* Open / forward remote port 4444
* Launch xvfb display and selenium server

        nohup Xvfb :0 -screen 0 1024x768x24 2>&1 >/dev/null &
        export DISPLAY=:0
        nohup java -jar ~/selenium-server.jar & > selenium-rc.log
* Check status here - `http://YOURHOSTNAME:4444/wd/hub/status`

In case you have issues running selenium scripts from a differnt path, export that path like this - `export PYTHONPATH=$PYTHONPATH:/path/to/your/repo`
