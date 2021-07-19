#! /bin/bash

source components/common.sh

NodeJS_Install

Useradd

Unzip_NPM_Install "Catalogue"

Servicefile_Update "Catalogue"
Update_Permission

Component_Restart "Catalogue"



