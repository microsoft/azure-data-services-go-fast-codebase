#!/bin/bash

tgcheck=$(command -v terragrunt) 
if [ -z "$tgcheck" ]; then tgcheck="NotInstalled";fi
if [ $tgcheck == "NotInstalled" ];then echo "Terragrunt Not Installed. Installing"; brew install terragrunt; else  echo "Terragrunt Installed"; fi
