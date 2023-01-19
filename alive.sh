#!/bin/bash

cookie=$(cat ./cookie.txt)
# username=''
projekt_code=''
apiNode=''
# queryUsername(){    
#  locationStr=$(curl 'https://www.doprax.com/u/me/' \
#   -H 'authority: www.doprax.com' \
#   -H 'accept: application/json, text/plain, */*' \
#   -H 'accept-language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7' \
#   -H 'cache-control: no-cache' \
#   -H "cookie: $cookie" \
#   -H 'pragma: no-cache' \
#   -H 'referer: https://www.doprax.com/u/me/' \
#   -H 'sec-ch-ua: "Chromium";v="104", " Not A;Brand";v="99", "Microsoft Edge";v="104"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "Windows"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.81 Safari/537.36 Edg/104.0.1293.47' \
#   -vvv 2>&1 | grep -E "Location: /u/")
#   locationStr=${locationStr#*/u/}
#   locationStr=${locationStr:0:-2}
#   username=$locationStr
#   echo "your name is $username"
# }

queryAppInfo(){
   appInfo=$(curl 'https://www.doprax.com/api/v1/projects/' \
  -H 'authority: www.doprax.com' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'cache-control: no-cache' \
  -H "cookie: $cookie" \
  -H 'pragma: no-cache' \
  -H 'referer: https://www.doprax.com/' \
  -H 'sec-ch-ua: "Chromium";v="104", " Not A;Brand";v="99", "Microsoft Edge";v="104"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.81 Safari/537.36 Edg/104.0.1293.47')

   apiNode=$(jq -r '.[0].node' <<< ${appInfo})
   echo "apiNode is $apiNode"

   projekt_code=$(jq -r '.[0].projekt_code'  <<< ${appInfo})
   echo "projekt_code is $projekt_code"
}

queryStatus(){
 appstatusJson=$(curl "$apiNode/api/v1/projects/$projekt_code/resources/?environment=sandbox" \
  -H 'authority: eu-dyqrfuajkib.doprax.com' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'cache-control: no-cache' \
  -H "cookie: $cookie" \
  -H 'pragma: no-cache' \
  -H 'referer: https://eu-dyqrfuajkib.doprax.com/' \
  -H 'sec-ch-ua: "Chromium";v="104", " Not A;Brand";v="99", "Microsoft Edge";v="104"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.81 Safari/537.36 Edg/104.0.1293.47')

   appStatus=$(jq -r '.[0].status' <<< ${appstatusJson})
   echo  $appStatus
}

startApp(){
    curl "$apiNode/api/v1/projects/$projekt_code/dev/" \
    -H 'authority: eu-dyqrfuajkib.doprax.com' \
    -H 'accept: application/json, text/plain, */*' \
    -H 'accept-language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7' \
    -H 'cache-control: no-cache' \
    -H 'content-type: application/x-www-form-urlencoded' \
    -H "cookie: $cookie" \
    -H 'origin: https://eu-dyqrfuajkib.doprax.com' \
    -H 'pragma: no-cache' \
    -H 'referer: https://eu-dyqrfuajkib.doprax.com//' \
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

queryAppInfo
queryStatus
appstatus=$(queryStatus)
 
if [ "$appstatus" == "not running" ]; then 
    startApp
else
    echo "running $appstatus"
fi
