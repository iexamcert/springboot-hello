#!/bin/bash
set -ex

CODE_PATH=""
#please change user and pass 
DOCKER_USER="user"
DOCKER_PASS="pass"
POM_FILE="pom.xml"
IMAGE_VERSION="V1"
DOCKER_PORT=""

#还原Dockerfile模板
cp Dockerfile.bak Dockerfile
#DOCKER_HOST="127.0.0.1"
###根据pom文件生成jar包的名称
function get_project_name() {
	JAR_BASE_NAME=`grep artifactId ${POM_FILE}|awk -F ">" '{print $2}' | awk -F "<" '{print $1}'|head -1`
	VERSION=`grep version ${POM_FILE}|awk -F ">" '{print $2}' | awk -F "<" '{print $1}'|sed -n '2p'`
	JAR_NAME="${JAR_BASE_NAME}"-"${VERSION}".jar
	DOCKER_PORT=""

}

###修改Dockerfile里的jar包名称
function change_name() {
	sed -i  "s/JAR_NAME/${JAR_NAME}/g" Dockerfile
}

###buid docker image
function docker_build() {
	#docker build -t ${DOCKER_HOST}/${JAR_BASE_NAME}:${DOCKER_VERSION} .
	echo "-------------docker build-----------------"
	docker build -t ${DOCKER_USER}/${JAR_BASE_NAME}:${IMAGE_VERSION} .
}

###docker login
function docker_login() {
	docker login --username ${DOCKER_USER} --password ${DOCKER_PASS}
}
###docker push
function docker_push() {
	docker push ${DOCKER_USER}/${JAR_BASE_NAME}:${IMAGE_VERSION}
}

###docker run
function docker_run() {
	echo "-------------docker run -----------------"
	docker run -d --name  -p8080:8080 myproject ${DOCKER_USER}/${JAR_BASE_NAME}:${IMAGE_VERSION}
}

###docker log and clean
function log_and_clean() {
	echo "运行docker logs --tail -f myproject 查看日志  "
	echo "docker logs --help 获取更多帮助"
	echo "docker rm -f myproject 删除此容器"
}

###maven mvn_package
function mvn_package() {
	docker run -it --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3.3-jdk-8 mvn clean install
	#statements
}

mvn_package
get_project_name
change_name
docker_build
docker_login
docker_push
docker_run
log_and_clean
