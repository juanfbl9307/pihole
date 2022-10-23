.DEFAULT_GOAL = help

check:
	@if ! [ $(shell command -v docker-compose 2> /dev/null) ]; then\
        echo "[WANR]: docker-compose bin not found use -> make docker-setup";\
        exit 1;\
	elif ! [ $(shell command -v docker 2> /dev/null) ]; then\
		echo "[WANR]: docker bin not found use -> make docker-setup";\
		exit 1;\
	else\
		echo "ALL CHECK AND READY TO GO!";\
	fi

ip-setup: static_ip.sh
	./static_ip.sh

docker-setup: docker-setup.sh
	./docker-setup.sh

services-install: install-services.sh docker-compose.yml
	./install-services.sh

all: services-install docker-setup check
	$(MAKE) check
	$(MAKE) docker-setup
	$(MAKE) ip-setup
	$(MAKE) services-install

help: # Show all commands
	@egrep -h '\s#\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
