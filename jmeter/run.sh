#!/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

while [[ $# -gt 0 ]]; do
  case "$1" in
    --branch)
        P_BRANCH=$2
        shift
        shift
        ;;
    --action)
        P_ACTION=$2
        shift
        shift
        ;;
    --version)
        P_VERSION=$2
        shift
        shift
        ;;
  esac
done

if [ "" == "${P_BRANCH}" ]
then
    P_BRANCH="master"
fi

if [ "" == "${P_VERSION}" ]
then
    P_VERSION="v1.0"
fi

if [[ "" == "${P_ACTION}" ]] ; then
    P_ACTION="run"
fi

. ${script_dir}/${P_BRANCH}/.env

if [[ "run" == "${P_ACTION}" ]] ; then
    mkdir -p "${script_dir}/output/${P_VERSION}"
    cd "${script_dir}/output/${P_VERSION}"
    ${JMETER_HOME}/bin/jmeter -t ${script_dir}/${P_VERSION}.jmx -p ${script_dir}/${P_BRANCH}/${P_VERSION}.properties  \
    -o "${script_dir}/output/${P_VERSION}" \
    -Jserver.rmi.ssl.disable=true 
fi