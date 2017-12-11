#!/bin/bash

USE_ALIYUN_MIRROR=1

MANAGER_IP=$1
NODE_IP=$2
TOKEN=`cat /vagrant/worker_token`

export DEBIAN_FRONTEND=noninteractive

if ! which docker >/dev/null 2>&1; then
	if [ -n "$USE_ALIYUN_MIRROR" ]
	then

        sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list

        # step 1: 安装必要的一些系统工具
        apt-get update
        apt-get -y install apt-transport-https ca-certificates curl software-properties-common
        # step 2: 安装GPG证书
        curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add -
        # Step 3: 写入软件源信息
        add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
        # Step 4: 更新并安装 Docker-CE
        apt-get -y update
        apt-get -y install docker-ce

        mkdir -p /etc/docker/
        echo '{"registry-mirrors": ["https://mytfd7zc.mirror.aliyuncs.com"] }' > /etc/docker/daemon.json
        #echo '{"registry-mirrors": ["https://mytfd7zc.mirror.aliyuncs.com"] }' | sudo tee /etc/docker/daemon.json
        service docker restart
	else
		curl -sSL https://get.docker.com/ | sh
	fi
	gpasswd -a vagrant docker
	docker swarm join --listen-addr ${NODE_IP}:2377 --advertise-addr ${NODE_IP} --token=$TOKEN ${MANAGER_IP}:2377
fi



