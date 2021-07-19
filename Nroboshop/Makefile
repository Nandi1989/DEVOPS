#!/bin/bash


help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

Frontend: ## Install Frontend.
	@sh components/Frontend.sh

Mongodb: ## Install mongodb.
	@sh components/Mongodb.sh

Cart: ## Install cart.
	@sh components/Cart.sh

Catalogue: ## Install catalogue.
	@sh components/Catalogue.sh

Mysql: ## Install mysql.
	@sh components/Mysql.sh

Payment: ## Install payment.
	@sh components/Payment.sh

Rabbitmq: ## setup rabbitmq
	@sh components/Rabbitmq.sh

Redis: ## setup redis
	@sh components/Redis.sh

Shipping: ## setup shipping
	@sh components/Shipping.sh

User: ## setup user
	@sh components/User.sh



