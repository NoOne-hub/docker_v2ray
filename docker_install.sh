#!/usr/bin/env bash
git clone https://github.com/NoOne-hub/v2ray_client v2ray_client/

echo "请输入面板用户名(默认为NoOne-hub)"
read user
if [ -z "${user}" ];then
 user="NoOne-hub"
fi

echo "面板密码为(默认为1234567890):"
read passwd
if [ -z "${passwd}" ];then
 passwd="1234567890"
fi

cat >> v2ray_client/config.py << EOF
    BASIC_AUTH_USERNAME = "$user"
    BASIC_AUTH_PASSWORD = "$passwd"
    BASIC_AUTH_FORCE = True
EOF

docker build -t v2ray:latest .
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
docker run -d --restart always --name v2ray \
  -v $SHELL_FOLDER/v2ray_client/config/v2ray/:/etc/v2ray \
  -p 10808:10808 -p 10809:10809 -p 8000:8000 v2ray
