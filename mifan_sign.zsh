#!/bin/zsh

# Usage: chmod +x mifan_sign.zsh && ./mifan_sign.zsh

accounts=(
  "ACCOUNT1" "PASSWORD1"
  "ACCOUNT2" "PASSWORD2"
  "ACCOUNT3" "PASSWORD3"
)

generate_md5() {
  printf "%s" "$1" | openssl dgst -md5 -r | awk '{print $1}'
}

mifan_sign() {
  user="$1"
  pass="$2"
  md5pass=$(generate_md5 "$pass")

  cookie_file=$(mktemp "/tmp/mifan_cookie_${user//[^A-Za-z0-9._-]/_}.XXXXXX")

  # login (silent)
  curl -s -c "$cookie_file" \
    -H "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 15_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Mobile/15E148 Safari/604.1" \
    -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8" \
    -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" \
    --data-urlencode "gid=689" \
    --data-urlencode "uid=${user}" \
    --data-urlencode "password=${md5pass}" \
    --data-urlencode "tad=" \
    --data-urlencode "encrypt=true" \
    'https://mifan.61.com/api/v1/login' >/dev/null

  # sign and print only the result (data or message)
  sign_resp=$(curl -s -b "$cookie_file" \
    -H "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 15_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Mobile/15E148 Safari/604.1" \
    'https://mifan.61.com/api/v1/event/dailysign/')

  result=$(printf '%s' "$sign_resp" | python3 -c 'import sys,json
try:
  j=json.load(sys.stdin)
  v=j.get("data") or j.get("message") or ""
  print(v)
except:
  print("")' 2>/dev/null)

  if [[ -n "$result" ]]; then
    echo "$(date '+%H:%M:%S') ${user} 签到结果: ${result}"
  else
    echo "$(date '+%H:%M:%S') ${user} 签到结果: 签到失败"
  fi

  rm -f "$cookie_file"
}

len=${#accounts[@]}
i=1
while (( i <= len )); do
  uid=${accounts[i]}
  pwd=${accounts[i+1]}
  mifan_sign "$uid" "$pwd"
  (( i += 2 ))
done
