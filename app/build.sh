#!/bin/bash 

repo=$1
appname=$2
apptype=$4
pkg_path=$5
context=$6

if [ -f "$pkg_path" ];then
  if [[ "${apptype}" =~ "web"]]then
    [ -z "$context" ] && context=${appname}
    docker build -t ${} -f Dockerfile-app --build-arg PKG_PATH="${pkg_path}" --build-arg PKG_NAME=${appname} --build-arg CONTEXT=${context} .
  else if [[ "${apptype}" =~ "mod" ]];then
    docker build -t ${repo}/${appname}:${version} -f Dockerfile-mod --build-arg PKG_PATH="${pkg_path}" --build-arg PKG_NAME=${appname} .
  else 
    echo "ERROR: 该类型未定义指定Dockerfile,或资源未生成,请联系管理员确认!"
  fi
else 
  echo "ERROR: 包${pkg_path}不存在,请确认!"
  exit 1
fi
