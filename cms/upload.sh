#!/bin/bash
SCRIPT_DIR="$(
  cd $(dirname $0)
  pwd
)"

echo ">> source build."
cd $SCRIPT_DIR/src/
npm run build

cd $SCRIPT_DIR
. .env

echo ">> upload cms start."

cp wp-config.php wp-config.php-e

sed -i "" -e "s/http\:\/\/localhost\:8080/https\:\/\/hiroshifujita.com/g" wp-config.php-e
sed -i "" -e "s/'GOOGLE_ANALYTICS_ID', ''/'GOOGLE_ANALYTICS_ID', '$GOOGLE_ANALYTICS_ID'/g" wp-config.php-e
sed -i "" -e "s/'FB_APP_ID', ''/'FB_APP_ID', '$FB_APP_ID'/g" wp-config.php-e
sed -i "" -e "s/'FORCE_SSL_LOGIN', false/'FORCE_SSL_LOGIN', true/g" wp-config.php-e
sed -i "" -e "s/'FORCE_SSL_ADMIN', false/'FORCE_SSL_ADMIN', true/g" wp-config.php-e
sed -i "" -e "s/off/on/g" wp-config.php-e

scp -F ~/.ssh/config .htaccess $SSH_HOST:$REMOTE_DIR/cms/.htaccess
scp -F ~/.ssh/config Dockerfile $SSH_HOST:$REMOTE_DIR/cms/Dockerfile
scp -F ~/.ssh/config wp-config.php-e $SSH_HOST:$REMOTE_DIR/cms/wp-config.php
scp -F ~/.ssh/config index.php $SSH_HOST:$REMOTE_DIR/cms/index.php
scp -F ~/.ssh/config -r $THEME_NAME/* $SSH_HOST:$REMOTE_DIR/cms/$THEME_NAME/

rm -rf wp-config.php-e

if [ -e deploy.log ]; then
  touch deploy.log
fi

echo `date '+%Y-%m-%d %H:%M:%S'`": upload cms success." >> deploy.log
echo ">> upload cms success."
