#!/bin/bash


help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

Frontend: ## install Frontend
	@sh components/Frontend.sh

mongodb: ## setup mongodb
	@sh components/Mongodb.sh

cart: ## setup cart
	@sh components/cart.sh

catalogue: ## setup catalogue
	@sh components/catalogue.sh

mysql: ## setup mysql
	@sh components/mysql.sh

payment: ## setup payment
	@sh components/payment.sh

rabbitmq: ## setup rabbitmq
	@sh components/rabbitmq.sh

redis: ## setup redis
	@sh components/redis.sh

shipping: ## setup shipping
	@sh components/shipping.sh

user: ## setup user
	@sh components/user.sh



