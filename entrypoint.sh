#!/bin/bash
v2ray -config=/etc/v2ray/config.json &
gunicorn -b 0.0.0.0:8000 -w 4 v2rayClient:app
