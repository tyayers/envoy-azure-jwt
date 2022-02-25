
curl -H "Authorization: Bearer $TOKEN" http://35.195.226.255:10000

wrk -H "Authorization: Bearer $TOKEN" -t12 -c100 -d180s -R2000 http://35.195.226.255:10000