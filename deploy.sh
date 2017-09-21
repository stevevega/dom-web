#!/bin/bash
tag=$1
commit_id=$2
version=$tag

# change the tag to latest when master was sent.
# also set the version to the commit id instead of latest.
if [ "$tag" = "master" ]; then
    tag="latest"
    version=$commit_id
fi

# create the service if not exists, update otherwise
sudo docker service ls | grep -q " dom-web "
if [ $? -eq 1 ]; then
    sudo docker service create \
        --container-label version="$version" \
        --name dom-web \
        --network dom \
        --publish 80:8080 \
        --replicas 4 \
        stevevega/dom-web:$tag \
    || { echo $0: Failed to create dom-web; exit 1; }
else
    sudo docker service update \
        --container-label-add version="$version" \
        --force \
        --image stevevega/dom-web:$tag \
        dom-web \
    || { echo $0: Failed to update dom-web; exit 1; }
fi

exit 0