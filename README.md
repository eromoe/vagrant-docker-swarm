# vagrant-docker-swarm

Easy build 3 vagrant with docker swarm. Alter from  https://github.com/denverdino/docker-swarm-mode-vagrant .

# Feature

1. Default use aliyun docker-ce source/ubuntu source (for china).  (comment `USE_ALIYUN_MIRROR` flag in`.sh` to disable)
2. Mount /data to /data
3. Default root password. (Not work now, original ubuntu box doesn't allow root login. )

# Usage

Create vm

    vagrant up

Go in Swarm manager

	vagrant ssh node-1

Check status

    docker node ls
