#!/bin/bash

if [[ $# -eq 0 ]]
then
  echo "usage: $0 [deploy | undeploy]"
  exit 1
elif [[ "$1" != "deploy" && "$1" != "undeploy" ]]
then
  echo "usage: $0 [deploy | undeploy]"
  exit 1
else
  command=$1
fi

if [[ $command = "deploy" ]]
then
  oc new-project mssql
  oc create secret generic mssql --from-literal=SA_PASSWORD="Sql2017fordemo" # notsecret
  oc apply -f ./storage.yaml
  oc apply -f ./deployment.yaml
elif [[ $command = "undeploy" ]]
then
  oc delete project mssql
fi

