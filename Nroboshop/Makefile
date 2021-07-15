#! /Bin/Bash

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

Frontend: ## Install Frontend.
	@sh Nroboshop/components/Frontend.sh

Mongodb: ## Install Mongodb.
	@sh Nroboshop/component/Mongodb.sh

