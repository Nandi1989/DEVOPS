#! /Bin/Bash


help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

Frontend: ## Install Frontend.
	@sh components/Frontend.sh

Mongodb: ## Install mongodb.
	@sh component/Mongodb.sh

Cart: ## Install cart.
	@sh component/Cart.sh

Catalogue: ## Install catalogue.
	@sh component/Catalogue.sh

Mysql: ## Install mysql.
	@sh component/Mysql.sh

Payment: ## Install payment.
	@sh component/Payment.sh

Rabbitmq: ## setup rabbitmq
	@sh components/Rabbitmq.sh

Redis: ## setup redis
	@sh components/Redis.sh

Shipping: ## setup shipping
	@sh components/Shipping.sh

User: ## setup user
	@sh components/User.sh



