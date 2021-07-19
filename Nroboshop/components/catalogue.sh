#! /bin/bash

source components/common.sh

NodeJS_Install

Useradd

Unzip_NPM_Install "catalogue"

Servicefile_Update "catalogue"
Update_Permission

Component_Restart "catalogue"



