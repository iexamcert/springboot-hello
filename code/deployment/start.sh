#!/bin/bash
set -ex
#判断系统为Centos或者Ubuntu
function SYS_OS() {
  SYSTEM_OS=`lsb_release -i|awk -F ' ' '{print $NF}'`
}

#安装ansible and boto
function INSTALL_ANSIBLE() {
  #statements
  if [[ ${SYSTEM_OS} == "Centos" ]];then
    yum install -y ansible && pip install boto boto3
  elif [[ ${SYSTEM_OS} == "Ubuntu" ]]; then
    apt install -y ansible && pip install boto boto3
  fi
}

#获取账号信息
function GET_AWS_SECRET() {
  #statements
  read -p "Enter your AWS_ACCESS_KEY_ID:" AWS_ACCESS_KEY_ID
  read -p "Enter your AWS_SECRET_ACCESS_KEY:" AWS_SECRET_ACCESS_KEY
  echo >> ~/.boto <<EOF
[Credentials]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOF
}

function CREATE_EC2_INSTANCE(parameter) {
  #statements
}

function INIT_EC2(parameter) {
  #statements
}
