#! /Bin/Bash


help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

Frontend: ## Install Frontend.
	@sh Nroboshop/components/Frontend.sh

mongodb: ## Install mongodb.
	@sh Nroboshop/component/mongodb.sh

cart: ## Install cart.
	@sh Nroboshop/component/cart.sh

catalogue: ## Install catalogue.
	@sh Nroboshop/component/catalogue.sh

mysql: ## Install mysql.
	@sh Nroboshop/component/mysql.sh

payment: ## Install payment.
	@sh Nroboshop/component/payment.sh

rabbitmq: ## setup rabbitmq
	@sh components/rabbitmq.sh

redis: ## setup redis
	@sh components/redis.sh

shipping: ## setup shipping
	@sh components/shipping.sh

user: ## setup user
	@sh components/user.sh



