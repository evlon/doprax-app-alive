#!/bin/bash

cookie=$(cat ./cookie.txt)

query(){

    curl 'https://eu-dyqrfuajkib.doprax.com/api/v1/projects/27f12d80-956e-11ed-8e66-b42e99837a9f/resources/?environment=sandbox' \
  -H 'authority: eu-dyqrfuajkib.doprax.com' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'cache-control: no-cache' \
  -H "cookie: $cookie" \
  -H 'pragma: no-cache' \
  -H 'referer: https://eu-dyqrfuajkib.doprax.com/liamgnc/projects/27f12d80-956e-11ed-8e66-b42e99837a9f/deploy/' \
  -H 'sec-ch-ua: "Chromium";v="104", " Not A;Brand";v="99", "Microsoft Edge";v="104"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.81 Safari/537.36 Edg/104.0.1293.47' \
  --compressed
}

start(){
    curl 'https://eu-dyqrfuajkib.doprax.com/api/v1/projects/27f12d80-956e-11ed-8e66-b42e99837a9f/dev/' \
    -H 'authority: eu-dyqrfuajkib.doprax.com' \
    -H 'accept: application/json, text/plain, */*' \
    -H 'accept-language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7' \
    -H 'cache-control: no-cache' \
    -H 'content-type: application/x-www-form-urlencoded' \
    -H "cookie: $cookie" \
    -H 'origin: https://eu-dyqrfuajkib.doprax.com' \
    -H 'pragma: no-cache' \
    -H 'referer: https://eu-dyqrfuajkib.doprax.com/liamgnc/projects/27f12d80-956e-11ed-8e66-b42e99837a9f/deploy/' \
    -H 'sec-ch-ua: "Chromium";v="104", " Not A;Brand";v="99", "Microsoft Edge";v="104"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "Windows"' \
    -H 'sec-fetch-dest: empty' \
    -H 'sec-fetch-mode: cors' \
    -H 'sec-fetch-site: same-origin' \
    -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.81 Safari/537.36 Edg/104.0.1293.47' \
    -d '{"operation":"run_all"}' \
    --compressed
}

appstatus=$(query | jq '.[].status')
echo $appstatus

if [ "$appstatus" == '"not running"' ]; then 
    start
fi