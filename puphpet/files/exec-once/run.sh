#!/bin/bash
echo "Meteor Setup"
curl https://install.meteor.com/ | /bin/sh
mkdir -p '/apps'
mkdir -p '/apps/codejet'
meteor create codejet
APP_PATH='/srv/codejet'
#rm -rf ${APP_PATH}/*
LOCAL_DATA_PATH=${APP_PATH}'/.meteor/local/db'


#meteor remove autopublish
#meteor remove insecure
#meteor add iron:router
#meteor add appcache

MONGO_STORAGE='/apps'
SRC_DATA=${MONGO_STORAGE}'/codejet'
SRC_DATA_APP=${MONGO_STORAGE}'/codejet/db'
CLIENT=${APP_PATH}'/client'
PRIVATE=${APP_PATH}'/private'
SERVER=${APP_PATH}'/server'
LIB=${APP_PATH}'/lib'
PUBLIC=${APP_PATH}'/public'
ASSETS=${APP_PATH}'/client/assets'
CSS=${ASSETS}'/css'
SCSS=${ASSETS}'/scss'
COLLECTIONS=${LIB}'/collections'
VIEWS=${CLIENT}'/views'

folders=($SRC_DATA $SRC_DATA_APP $CLIENT $SERVER $LIB $PUBLIC $PRIVATE $ASSETS $CSS $SCSS $COLLECTIONS $VIEWS)
for folder in "${folders[@]}"
 do
   mkdir ${folder}
 done

ln -s ${SRC_DATA_APP} ${LOCAL_DATA_PATH}
chown vagrant:vagrant $SRC_DATA_APP
touch ${LIB}'/router.js'
touch ${APP_PATH}'/settings.json'
