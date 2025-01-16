#!/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${script_dir}/.."
script_dir="$(pwd)"

. ${script_dir}/.env

cd "${script_dir}/.."

while [[ $# -gt 0 ]]; do
  case "$1" in
    --action)
        P_ACTION=$2
        shift
        shift
        ;;
    --app-name)
        P_APP_NAME=$2
        shift
        shift
        ;;
    --app-version)
        P_APP_VERSION=$2
        shift
        shift
        ;;
  esac
done

if [[ "" == "${P_ACTION}" ]] ; then
    P_ACTION="login"
fi

if [[ "" == "${P_APP_NAME}" ]] ; then
    P_APP_NAME="${ENV_APP_NAME}"
fi

if [[ "" == "${P_APP_VERSION}" ]] ; then
    P_APP_VERSION="${ENV_APP_VERSION}"
fi

if [[ "" == "${P_IMG_REGISTRY_DOMAIN}" ]] ; then
    P_IMG_REGISTRY_DOMAIN="${ENV_IMG_REGISTRY_DOMAIN}"
fi

if [[ "login" == "${P_ACTION}" ]] ; then
    docker login ${P_IMG_REGISTRY_DOMAIN}
fi

if [[ "push" == "${P_ACTION}" ]] ; then
    docker tag "${P_APP_NAME}:${P_APP_VERSION}" "${P_IMG_REGISTRY_DOMAIN}/${P_APP_NAME}:${P_APP_VERSION}"
    docker push "${P_IMG_REGISTRY_DOMAIN}/${P_APP_NAME}:${P_APP_VERSION}"
fi