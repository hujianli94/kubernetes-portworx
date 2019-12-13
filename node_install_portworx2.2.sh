#!/bin/bash

#-------------------------------------------------------------------
# export KBVER=$(kubectl version --short | awk -Fv '/Server Version: / {print $3}')

# PX_IMGS="$(curl -fsSL "https://install.portworx.com/2.2/?kbver=$KBVER&type=oci&lh=true&ctl=true&stork=true&csi=true" | awk '/image: /{print $2}' | sort -u)"
# PX_IMGS="$PX_IMGS portworx/talisman:latest portworx/px-node-wiper:2.1.4"
# PX_ENT=$(echo "$PX_IMGS" | sed 's|^portworx/oci-monitor:|portworx/px-enterprise:|p;d')

# echo $PX_IMGS $PX_ENT | xargs -n1 docker pull

#-------------------------------------------------------------------
pause_version=pause:3.1


# 需要安装的px镜像
Install1_package=(
lh-config-sync:2.0.5 
lh-stork-connector:2.0.5 
oci-monitor:2.2.0.2 
px-lighthouse:2.0.5 
talisman:latest 
px-node-wiper:2.1.4
talisman:latest 
px-node-wiper:2.1.4 
px-enterprise:2.2.0.2

)

for imageName in ${Install1_package[@]} ; do
    docker pull portworx/$imageName
	echo -e "\033[32m-------------$imageName pull complete......\033[0m"
done


Install2_package=(
csi-provisioner:v1.3.0-1 
csi-resizer:v0.2.0-1 
csi-snapshotter:v1.2.0-1 

)

for imageName in ${Install2_package[@]} ; do
    docker pull quay.io/openstorage/$imageName
	echo -e "\033[32m-------------$imageName pull complete......\033[0m"
done           

Install3_package=(
kube-controller-manager-amd64:v1.14.8
kube-scheduler-amd64:v1.14.8

)

for imageName in ${Install3_package[@]} ; do
    docker pull mirrorgooglecontainers/$imageName
	docker tag mirrorgooglecontainers/$imageName gcr.io/google_containers/$imageName
	docker rmi mirrorgooglecontainers/$imageName
	echo -e "\033[32m-------------$imageName pull complete......\033[0m"
	
done           



docker pull quay.io/k8scsi/csi-node-driver-registrar:v1.1.0
echo -e "\033[32m-------------quay.io/k8scsi/csi-node-driver-registrar:v1.1.0 pull complete......\033[0m"

docker pull openstorage/stork:2.3.1 
echo -e "\033[32m-------------stork:2.3.1 pull complete......\033[0m"



docker pull mirrorgooglecontainers/$pause_version
docker tag mirrorgooglecontainers/${pause_version} k8s.gcr.io/$pause_version
docker rmi mirrorgooglecontainers/$pause_version
echo -e "\033[32m${pause_version} install Successful......\033[0m"
echo -e "\033[32mNode image install Successful......\033[0m"
