#!/bin/bash
su vagrant
echo "Meteor Setup"
curl https://install.meteor.com/ | /bin/sh
APP_PATH='/var/www'
cd ${APP_PATH}
meteor create codejet
mv ${APP_PATH}'/codejet/.meteor' ${APP_PATH}'/'
rm -rf ${APP_PATH}'/codejet'
#rm -rf ${APP_PATH}/*
LOCAL_DATA_PATH=${APP_PATH}'/.meteor/local/db'


#meteor remove autopublish
#meteor remove insecure
#meteor add iron:router
#meteor add appcache
sudo su
MONGO_STORAGE='/mongodb'
SRC_DATA=${MONGO_STORAGE}'/codejet'
SRC_DATA_APP=${MONGO_STORAGE}'/codejet/db'

folders=($MONGO_STORAGE $SRC_DATA $SRC_DATA_APP $CLIENT $SERVER $LIB $PUBLIC $PRIVATE $ASSETS $CSS $SCSS $COLLECTIONS $VIEWS)
for folder in "${folders[@]}"
 do
   mkdir ${folder}
 done

ln -s ${SRC_DATA_APP} ${LOCAL_DATA_PATH}
chown vagrant:vagrant $SRC_DATA_APP
