#!/bin/bash

#Time

log_time=`date +[%Y-%m-%d]%H:%M:%S`

 

###manual_properties###

tomcat_basehome=/data/tomcat8081

tomcat_port=8080

shell_environment=/bin/bash

war_Dir=/var/lib/jenkins/workspace/CloudPayment/target

war_Name=library.war

war_home=/home/zencj/webapps

backup_name=/data/backup/tomcat8081

back_name=library

###manual_properties###

 

#update server environment

echo "**********************************  ${log_time} *************************************"

echo "updating server  environment start"

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.302.b08-0.el8_4.x86_64

export JRE_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.302.b08-0.el8_4.x86_64/jre

export PATH =$JAVA_HOME/bin:$PATH

export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

sleep 3

echo "updating server  environment  end"

 

#transfer  application package

deploy_Loaction = ${tomcat_basehome}/webapps/

war_Dir_Data=`ls ${war_Dir}`

echo "--------------  begin  transfer  war package to tomcat webapps -------------------"

 

if [ -z $war_Dir ];then

     echo "Folder ${war_Dir} is empty.please check war package in this folder!"

     exit 1

else

     echo "Find ${war_Dir} exist war package ${war_Name}"

    # echo "deleteing old  package ${war_Name} in ${war_Dir}"

    # rm ${war_Dir}/${war_Name}

     echo "deleteing old  package ${war_Name} in ${deploy_Loaction}"

     echo "备份library.war"

     rm -rf ${backup_name}/${back_name}

     cp -r ${deploy_Loaction}/${war_Name} ${backup_name}

     rm ${deploy_Loaction}${war_Name}

     echo "start  transfer ${war_Name} to ${deploy_Loaction}"

     cp -r ${war_home}/${war_Name}  ${deploy_Loaction}

     echo "start chmod war"

     chmod 777 ${deploy_Loaction}/${war_name}

     sleep 3

fi

echo "--------------  transfer  war package to tomcat webapps  end -------------------"

#reboot tomcat

echo " >>>>>>>  rebooting  tomcat begin <<<<<<<<"

cd ${deploy_Loaction}

./start.sh

echo "************************ deploy war package into container Successlly  **********************************"