#!/usr/bin/env bash
killTomcat(){
    pid=`ps -ef|grep tomcat|grep java|awk '{print $2}'`
    echo "tomcat Id list :$pid"
    if [ "$pid" = "" ]
    then
        echo "no tomcat pid alive"
    else
        kill -9 $pid
    fi
}

cd $WORKSPACE/jenkinsdeploy
mvn clean install
killTomcat
rm -rf $TOMCAT_HOME/webapps/jenkinsdeploy
rm -f $TOMCAT_HOME/webapps/jenkinsdeploy.war
cp $WORKSPACE/jenkinsdeploy/target/jenkinsdeploy.war $TOMCAT_HOME/webapps/
cd $TOMCAT_HOME
sh bin/startup.sh