#/bin/bash

# 下载portworx所需的镜像
#PX_IMGS="$(curl -fsSL "https://install.portworx.com/2.2/?kbver=$KBVER&type=oci&lh=true&ctl=true&stork=true&csi=true" | awk '/image: /{print $2}' | sort -u)"
#PX_IMGS="$PX_IMGS portworx/talisman:latest portworx/px-node-wiper:2.1.4"
#PX_ENT=$(echo "$PX_IMGS" | sed 's|^portworx/oci-monitor:|portworx/px-enterprise:|p;d')
#echo $PX_IMGS $PX_ENT | xargs -n1 docker pull


# 将worker节点所有镜像保存成tar.gz文件，用于px的worker节点的直接载入，可以docker load -i的方式，快速加载镜像
image_list=`docker images|grep -v REPOSITORY| awk '{print $1":"$2}'`

docker save -o portworx2-2.tar.gz $image_list $PX_ENT