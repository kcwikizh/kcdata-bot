#!/bin/sh

TARGET_FOLDER=./tmp/kcdata-$1
git clone https://$GIT_USER@github.com/kcwikizh/kcdata.git $TARGET_FOLDER
cd $TARGET_FOLDER
git checkout -b bot-update-$1

cd ../..
ruby script/kcdata-gen/equiptype.rb $TARGET_FOLDER
ruby script/kcdata-gen/furniture.rb $TARGET_FOLDER
ruby script/kcdata-gen/ship.rb $TARGET_FOLDER
ruby script/kcdata-gen/slotitem.rb $TARGET_FOLDER
ruby script/kcdata-gen/useitem.rb $TARGET_FOLDER

cd $TARGET_FOLDER
git add .
git commit -F- <<EOF
Update (`date "+%Y/%m/%d"`)

close #$1
EOF

git push origin bot-update-$1

cd ../..
rm -rf $TARGET_FOLDER
