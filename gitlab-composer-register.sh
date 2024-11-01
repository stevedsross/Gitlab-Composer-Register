#!/bin/bash

source .gitlab-token.sh

if [ -z ${token+x} ];
  
then
  echo "missing token. please add gitlab token to .gitlab-token file in the same directory as this script."
  exit 1
fi

while getopts p:v: flag
do
  case "${flag}" in
    p) project=${OPTARG};;
    v) version=${OPTARG};;
  esac
done

if [ -z ${project+x} ];
then
  echo "please specify the project ID using the -p flag"
  exit 1
fi

if [ -z ${version+x} ];

then
  echo "please specify the version using the -v flag (ie, -v 1.2.3)"
  exit 1
fi

curl --data tag=v${version} "https://token:${token}@gitlab.com/api/v4/projects/${project}/packages/composer"
