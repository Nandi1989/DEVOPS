#!/bin/bash


help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

Frontend: ## install Frontend
	@sh Frontend.sh

mongodb: ## setup mongodb
	@sh Mongodb.sh

cart: ## setup cart
	@sh cart.sh

catalogue: ## setup catalogue
	@sh catalogue.sh

mysql: ## setup mysql
	@sh mysql.sh

payment: ## setup payment
	@sh payment.sh

rabbitmq: ## setup rabbitmq
	@sh rabbitmq.sh

redis: ## setup redis
	@sh redis.sh

shipping: ## setup shipping
	@sh shipping.sh

user: ## setup user
	@sh user.sh



