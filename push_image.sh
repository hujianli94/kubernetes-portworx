#!/bin/bash
image_list=`docker images|grep -v REPOSITORY| awk '{print $1":"$2}'`
for i in $image_list
do
	#echo -e "$i futongcloud/${i##*/}"
	docker tag $i futongcloud/${i##*/}
	docker push futongcloud/${i##*/}
done