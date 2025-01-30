#!/bin/bash
#Implementación basada en https://tomd.xyz/camel-maven/

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

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
    --container-name)
        P_CONTAINER_NAME=$2
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

if [[ "" == "${P_ACTION}" ]] ; then
    P_ACTION="run"
fi

if [[ "" == "${P_APP_NAME}" ]] ; then
    P_APP_NAME="${ENV_APP_NAME}"
fi

if [[ "" == "${P_APP_VERSION}" ]] ; then
    P_APP_VERSION="${ENV_APP_VERSION}"
fi

if [[ "" == "${P_CONTAINER_NAME}" ]] ; then
    P_CONTAINER_NAME="${P_APP_NAME}"
fi

if [[ "" == "${P_APP_VERSION}" ]] ; then
    P_APP_VERSION="${ENV_APP_VERSION}"
fi

if [[ "build" == "${P_ACTION}" ]] ; then
    ${script_dir}/module/build.sh --app-name "${P_APP_NAME}" --app-version "${P_APP_VERSION}"
fi

if [[ "publish" == "${P_ACTION}" ]] ; then
    ${script_dir}/module/registry.sh --action login
    ${script_dir}/module/registry.sh --app-name "${P_APP_NAME}" --app-version "${P_APP_VERSION}" --action push
fi

if [[ "k8s-cfg-map-create" == "${P_ACTION}" ]] ; then
    ${script_dir}/module/k8s.sh --action cfg-map-create
fi

if [[ "k8s-cfg-map-backup" == "${P_ACTION}" ]] ; then
    ${script_dir}/module/k8s.sh --action cfg-map-backup
fi

if [[ "k8s-cfg-map-update" == "${P_ACTION}" ]] ; then
    ${script_dir}/module/k8s.sh --action cfg-map-update
fi

if [[ "k8s-run" == "${P_ACTION}" ]] ; then
    ${script_dir}/module/k8s.sh --action run
fi

if [[ "k8s-expose" == "${P_ACTION}" ]] ; then
    ${script_dir}/module/k8s.sh --k8s-host-port "${P_K8S_HOST_PORT}" --k8s-svc-port "${P_K8S_SVC_PORT}" --action expose 
fi

if [[ "k8s-remove" == "${P_ACTION}" ]] ; then
    ${script_dir}/module/k8s.sh --action remove
fi

if [[ "run" == "${P_ACTION}" ]] ; then
    if [[ "" == "$(docker network list | grep ${ENV_VLAN})" ]] ; then
        docker network create -d bridge "${ENV_VLAN}"
    fi
    docker run -d --name "${P_CONTAINER_NAME}" \
            --env-file="${script_dir}/module/docker/.env" --network ${ENV_VLAN} \
            "${P_APP_NAME}:${P_APP_VERSION}" .
fi

if [[ "stop" == "${P_ACTION}" ]] ; then
    if [[ "" != "$(docker ps | grep ${P_CONTAINER_NAME})" ]] ; then
        docker stop "${P_CONTAINER_NAME}"
    fi
fi

if [[ "remove" == "${P_ACTION}" ]] ; then
    ${script_dir}/run.sh --container-name ${P_CONTAINER_NAME} --action stop
    docker rm "${P_CONTAINER_NAME}"
fi

if [[ "logs" == "${P_ACTION}" ]] ; then
    docker logs -f "${P_CONTAINER_NAME}"
fi

if [[ "start" == "${P_ACTION}" ]] ; then
    docker start "${P_CONTAINER_NAME}"
fi

if [[ "restart" == "${P_ACTION}" ]] ; then
    ${script_dir}/run.sh --container-name ${P_CONTAINER_NAME} --action stop
    ${script_dir}/run.sh --container-name ${P_CONTAINER_NAME} --action start
fi

if [[ "sonarqube" == "${P_ACTION}" ]] ; then
    ${script_dir}/module/build.sh --action sonarqube
fi