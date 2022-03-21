
#curl -H "Authorization: Bearer $TOKEN" http://35.195.226.255:10000

#wrk -H "Authorization: Bearer $TOKEN" -t12 -c100 -d180s -R2000 http://35.195.226.255:10000

# First without envoy (local test)
wrk -t40 -c400 -d30s -R4000 http://localhost:8080

# Now with envoy
wrk -H "Authorization: Bearer $TOKEN" -t40 -c400 -d30s -R4000 http://localhost:10000