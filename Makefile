

SHELL:=/bin/bash

wipe-all: down remove_stopped_containers wipe-volumes wipe-images wipe-containers

wipe-volumes:
	@if [[ -n "$$(docker volume ls -qf dangling=true)" ]]; then\
		docker volume rm -f $$(docker volume ls -qf dangling=true);\
	fi
	@docker volume ls -qf dangling=true | xargs -r docker volume rm

wipe-images:
	@if [[ -n "$$(docker images --filter "dangling=true" -q --no-trunc)" ]]; then\
		docker rmi -f $$(docker images --filter "dangling=true" -q --no-trunc);\
	fi
	@if [[ -n "$$(docker images | grep "none" | awk '/ / { print $3 }')" ]]; then\
		docker rmi -f $$(docker images | grep "none" | awk '/ / { print $3 }');\
	fi

wipe-containers:
	@if [[ -n "$$(docker ps -qa --no-trunc --filter "status=exited")" ]]; then\
		docker rm -f $$(docker ps -qa --no-trunc --filter "status=exited");\
	fi

install-docker:
	@echo "Installing Docker"

	@sudo apt-get update

	@sudo apt-get install \
		apt-transport-https \
		ca-certificates \
		curl \
		software-properties-common -y

	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	@sudo add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
		$$(lsb_release -cs) \
		stable"

	@sudo apt-get update

	@sudo apt-get --yes --no-install-recommends install docker-ce

	@sudo usermod --append --groups docker "$$USER"

	@sudo systemctl enable docker

	@echo "Waiting for Docker to start..."
	@sleep 3

	@sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

	@sudo chmod +x /usr/local/bin/docker-compose
	@sleep 5
	@echo "Docker Installed successfully"

install-docker-if-not-already-installed:
	@if [ -z "$$(which docker)" ]; then\
		make install-docker;\
	fi

down:
	@docker-compose down
	@docker-compose kill

remove_stopped_containers:
	@docker-compose rm -v

check-and-create-network:
	@docker network ls | grep ptoy_network > /dev/null || docker network create ptoy_network

build-all-docker-images:
	@echo "----------------------------------------"
	@echo "Building docker images, please wait....."
	@echo "----------------------------------------"
	@docker-compose build --force-rm
	@echo "----------------------------------------"
	@echo "Docker images are ready"
	@echo "----------------------------------------"

set-up: install-docker-if-not-already-installed check-and-create-network down remove_stopped_containers build-all-docker-images install-node install-ganache

install-node:
	@echo "----------------------------------------"
	@echo "installing node"
	@echo "----------------------------------------"
	@sudo apt-get update
	@curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
	@sudo bash nodesource_setup.sh
	@sudo apt-get --yes install nodejs
	@sudo npm i -g yarn
	@echo "----------------------------------------"
	@echo "node installed"
	@echo "----------------------------------------"

install-ganache:
#	@sudo docker run -d -p 8545:8545 --name ganache trufflesuite/ganache-cli:latest -d -a 50 -m "man swing emotion lucky riot together behind connect swim allow protect winter" --host 0.0.0.0 --debug
	@echo "----------------------------------------"
	@echo "installing ganache"
	@echo "----------------------------------------"
	@docker-compose up -d ganache
	@docker-compose ps
	@echo "----------------------------------------"
	@echo "ganache installed"
	@echo "----------------------------------------"

migrate-contract: compile-contract
	@echo "---------------------------------------------------------------"
	@echo "Migrating Contracts"
	@echo "---------------------------------------------------------------"
	@docker-compose run --rm ptoy_dev_token ./node_modules/.bin/truffle migrate --network development
	@echo "---------------------------------------------------------------"
	@echo "Contracts deployed"
	@echo "---------------------------------------------------------------"

status:
	@echo "----------------------------------"
	@echo "Available Dev PTOY Token Services"
	@echo "----------------------------------"
	@docker-compose ps --services
	@echo "----------------------------------"
	@echo "Running Dev PTOY Token Services"
	@echo "----------------------------------"
	@docker-compose ps
	@echo "----------------------------------"

reset: wipe-all
