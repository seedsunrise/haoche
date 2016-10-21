#!/bin/bash

tomcat_path='/www/apache-tomcat-8.0.32'

deploy_config_to=$deploy_to/config

deploy_scripts_to=$deploy_to/scripts

java_main_class=com.haoche.bos.Application

app_version='0.0.1-SNAPSHOT'

app_name=haoche-bos

app_war_name='haoche-bos.war'

app_jar_name="${app_name}-${app_version}.jar"

# 构建命令
build_exec="gradlew build -x test"

# 可配置的文件
configurable_files=("application.properties" "log4j2.xml")

app_launch_command="nohup java -Dloader.path=${deploy_config_to},$deploy_to/${app_jar_name} -jar $deploy_to/${app_jar_name} > $deploy_to/server.out 2>&1 &"
