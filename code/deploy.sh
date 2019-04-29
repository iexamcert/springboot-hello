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
function SED_CONFIG() {
  sed -i "s/#host_key_checking = False/host_key_checking = False/g" /etc/ansible/ansible.cfg
}

#获取账号信息
function GET_AWS_SECRET() {
  #statements
  read -p "Enter your AWS_ACCESS_KEY_ID:" AWS_ACCESS_KEY_ID
  read -p "Enter your AWS_SECRET_ACCESS_KEY:" AWS_SECRET_ACCESS_KEY
  cat  <<EOF > ~/.boto
[Credentials]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOF
}

function CREATE_KEY() {
	ansible-playbook ../Auto-Deploy/createnewkeypair.yml
}

function CREATE_EC2_INSTANCE() {
  ansible-playbook ../Auto-Deploy/create_ec2.yml --private-key=/tmp/aws-private.pem  

}
function MV_DEPLOY_SHELL() {
	cp `pwd`/deployment/env/${1}.sh .
}

function NOTE() {
	echo "请访问 `cat /tmp/ec2_ip`:8080/hello 服务"
        echo "测试完请清除key和ec2实例，运行："
        echo "删除ec2: ansible-playbook ../Auto-Deploy/removekey.yml"
        echo "删除ec2私钥: ansible-playbook ../Auto-Deploy/terminate_ec2.yml"
}

SYS_OS
INSTALL_ANSIBLE
GET_AWS_SECRET
SED_CONFIG
CREATE_KEY
MV_DEPLOY_SHELL $1
CREATE_EC2_INSTANCE
NOTE
