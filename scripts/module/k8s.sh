#!/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. ${script_dir}/k8s/.env
. ${script_dir}/k8s/sshMethods.sh

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
    --k8s-app)
        P_K8S_APP=$2
        shift
        shift
        ;;
    --k8s-version)
        P_K8S_VERSION=$2
        shift
        shift
        ;;
    --k8s-deployment)
        P_K8S_DEPLOYMENT=$2
        shift
        shift
        ;;
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

if [[ "" == "${P_ACTION}" ]] ; then
    P_ACTION="run"
fi

if [[ "" == "${P_K8S_DEPLOYMENT}" ]] ; then
    P_K8S_DEPLOYMENT=synopsis-test
fi

if [[ "" == "${P_K8S_SERVICE}" ]] ; then
    P_K8S_SERVICE=synopsis-test-svc
fi

if [[ "" == "${P_K8S_CFG_MAP}" ]] ; then
    P_K8S_CFG_MAP=synopsis-test-cfg-map
fi

if [[ "" == "${P_K8S_NAMESPACE}" ]] ; then
    P_K8S_NAMESPACE="${ENV_NAMESPACE}"
fi

if [[ "" == "${P_NAME_SECRET}" ]] ; then
    P_NAME_SECRET="regcred"
fi

if [[ "" == "${P_K8S_HOST_PORT}" ]] ; then
    P_K8S_HOST_PORT="${ENV_K8S_HOST_PORT}"
fi

if [[ "" == "${P_K8S_SVC_PORT}" ]] ; then
    P_K8S_SVC_PORT="${ENV_K8S_SVC_PORT}"
fi

if [[ "" == "${P_K8S_APP}" ]] ; then
    P_K8S_APP="${ENV_APP_NAME}"
fi

if [[ "" == "${P_K8S_VERSION}" ]] ; then
    P_K8S_VERSION="${ENV_APP_VERSION}"
fi

VOLUME_NAME="${P_K8S_APP}"
VOLUME_DIR="${VOLUMES_PATH}/${P_K8S_APP}"

export P_K8S_NAMESPACE="${P_K8S_NAMESPACE}"
export P_K8S_VERSION="${P_K8S_VERSION}"
export P_K8S_APP="${P_K8S_APP}"
export VOLUME_NAME_DATA="${VOLUME_NAME}-config"
export VOLUME_DIR_DATA="${VOLUME_DIR}/config"

function evalMountDirs() {
    
    CANCEL_COMMAND=false

    evalExistsRemoteDirectory ${VOLUME_DIR_DATA}
    if [[ "0" == "$?" ]] ; then
        CANCEL_COMMAND=true
    fi

    if [[ true == $CANCEL_COMMAND ]] ; then
        echo "================"
        echo "Execute commands"
        echo "================"
        echo "minikube ssh"

        showMsgCreateRemoteDirectory $VOLUME_DIR_DATA

        echo "================"
        exit 0
    fi
}

if [[ "minikube-sync" == "${P_ACTION}" ]] ; then

    evalMountDirs

    echo "Send ${script_dir}/../config to ${VOLUME_DIR_DATA}"
    scp -i $(minikube ssh-key) -r ${script_dir}/../config/* docker@$(minikube ip):${VOLUME_DIR_DATA}
fi

if [[ "run" == "${P_ACTION}" ]] ; then
    
    evalMountDirs

    kubectl create secret generic "${P_K8S_APP}-secret" --namespace=${P_K8S_NAMESPACE} --from-env-file=${script_dir}/module/k8s/${P_K8S_APP}.env
    envsubst < "${script_dir}/module/k8s/${P_K8S_APP}-pv.yaml" | kubectl apply -f -
    envsubst < "${script_dir}/module/k8s/${P_K8S_APP}.yaml" | kubectl apply -f -
fi

if [[ "expose" == "${P_ACTION}" ]] ; then
    bash "${script_dir}/module/k8s/expose.sh" --k8s-service "${P_K8S_SERVICE}" --k8s-namespace "${P_K8S_NAMESPACE}" --k8s-host-port "${P_K8S_HOST_PORT}" --k8s-svc-port "${P_K8S_SVC_PORT}"
fi

if [[ "stop" == "${P_ACTION}" ]]; then
    kubectl scale deployment ${P_K8S_APP} --namespace ${P_K8S_NAMESPACE} --replicas=0
fi

if [[ "remove" == "${P_ACTION}" ]] ; then
    envsubst < "${script_dir}/module/k8s/${P_K8S_APP}.yaml" | kubectl delete -f -
    envsubst < "${script_dir}/module/k8s/${P_K8S_APP}-pv.yaml" | kubectl delete -f -
    kubectl delete secret --namespace=${P_K8S_NAMESPACE} "${P_K8S_APP}-secret"
fi

if [[ "start" == "${P_ACTION}" ]]; then
    kubectl scale deployment ${P_K8S_APP} --namespace ${P_K8S_NAMESPACE} --replicas=1
fi

if [[ "restart" == "${P_ACTION}" ]]; then
    ${script_dir}/module/k8s.sh --action stop
    ${script_dir}/module/k8s.sh --action start
fi

if [[ "rerun" == "${P_ACTION}" ]]; then
    ${script_dir}/module/k8s.sh --action remove
    ${script_dir}/module/k8s.sh --action run
fi

export P_K8S_NAMESPACE=
export P_K8S_APP=
export P_K8S_VERSION=
export VOLUME_NAME_DATA=
export VOLUME_DIR_DATA=