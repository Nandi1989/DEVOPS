#!/bin/bash


help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

frontend: ## Install frontend.
	@sh components/frontend.sh

mongodb: ## Install mongodb.
	@sh components/mongodb.sh

cart: ## Install cart.
	@sh components/cart.sh

catalogue: ## Install catalogue.
	@sh components/catalogue.sh

mysql: ## Install mysql.
	@sh components/mysql.sh

payment: ## Install payment.
	@sh components/payment.sh

rabbitmq: ## setup rabbitmq
	@sh components/rabbitmq.sh

redis: ## setup redis
	@sh components/redis.sh

shipping: ## setup shipping
	@sh components/shipping.sh

user: ## setup user
	@sh components/user.sh