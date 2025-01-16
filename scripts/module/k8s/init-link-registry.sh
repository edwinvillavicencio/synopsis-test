#!/bin/bash
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
. ${script_dir}/.env

cd "${script_dir}/../.."
script_dir="$(pwd)"

. ${script_dir}/.env

while [[ $# -gt 0 ]]; do
  case "$1" in
    --username)
        P_USERNAME=$2
        shift
        shift
        ;;
    --password)
        P_PASSWORD=$2
        shift
        shift
        ;;
  esac
done

if [[ "" == "${P_USERNAME}" ]]; then
    echo "Ingrese parametro --username"
    exit 0
fi

if [[ "" == "${P_PASSWORD}" ]]; then
    echo "Ingrese parametro --password"
    exit 0
fi

if [[ "" == "${P_IMG_REGISTRY_DOMAIN}" ]] ; then
    P_IMG_REGISTRY_DOMAIN="${ENV_IMG_REGISTRY_DOMAIN}"
fi

kubectl create secret docker-registry regcred --docker-server="${P_IMG_REGISTRY_DOMAIN}" --docker-username="${P_USERNAME}" --docker-password="${P_PASSWORD}"
