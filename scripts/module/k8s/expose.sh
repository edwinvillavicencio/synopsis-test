#!/bin/bash
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

. ${script_dir}/.env

cd "${script_dir}/../.."
script_dir="$(pwd)"

. ${script_dir}/.env

while [[ $# -gt 0 ]]; do
  case "$1" in
    --k8s-service)
        P_K8S_SERVICE=$2
        shift
        shift
        ;;
    --k8s-namespace)
        P_K8S_NAMESPACE=$2
        shift
        shift
        ;;
    --k8s-host-port)
        P_K8S_HOST_PORT=$2
        shift
        shift
        ;;
    --k8s-svc-port)
        P_K8S_SVC_PORT=$2
        shift
        shift
        ;;
  esac
done

if [[ "" == "${P_K8S_HOST_PORT}" ]] ; then
    echo "Ingrese parametro --k8s-host-port"
    echo "Ejemplo: --k8s-host-port 8080"
    exit 0
fi

if [[ "" == "${P_K8S_SVC_PORT}" ]] ; then
    echo "Ingrese parametro --k8s-svc-port"
    echo "Ejemplo: --k8s-svc-port 8080"
    exit 0
fi

kubectl port-forward svc/${P_K8S_SERVICE} -n "${P_K8S_NAMESPACE}" --address 0.0.0.0 "${P_K8S_HOST_PORT}:${P_K8S_SVC_PORT}"
# minikube service "${P_K8S_SERVICE}" --url
