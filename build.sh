#!/bin/bash


# implies we're in a clone of nodecg
echo "Building nodecg image"

rm -fr node_modules
echo "Installing npm dependencies for nodecg"

npm install --production

echo "Installing bundles"
echo "Deleting previous bundles"
rm -fr bundles/*

BUNDLES="\
git@github.ibm.com:skrum/twitch-follower \
git@github.ibm.com:skrum/my-first-bundle"


for bundle in $BUNDLES
do
    echo $bundle
    pushd bundles
    git clone $bundle
    dir=$(echo $bundle | cut -d '/' -f 2)
    cd $dir
    npm install
    popd
done



image=nodecgibmdeveloper

# depends on being logged in to quay.io

docker build --no-cache -t quay.io/nibalizer/${image} .
docker push quay.io/nibalizer/${image}

# deploy to kubernetes (update kubernetes deployment)

kubectl apply -f deployment/manifest.yaml
# Not managed: secrets/configuration

