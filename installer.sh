#!/bin/bash
npm install -D postman-to-k6
# ?? Ask hari about alternatives for this - ssh-key needs to be generated and added to the ec2 metadata while it gets created using terraform
# Copy wildcard parameters from paramstore to /env/envfilename
# git clone repo with this codebase and postman collections
mkdir k6-scripts
docker-compose up -d influxdb grafana
for filename in postman_collections/*.json; do
#  postman-to-k6 $filename -e environment/environment.json -o k6-scripts/$(basename "$filename-k6script.js") #/"$(basename "$filename-script.js")"
  postman-to-k6 $filename -o k6-scripts/$(basename "$filename-k6script.js") #/"$(basename "$filename-script.js")"
done
#postman-to-k6 postman_collections/stress.json -o k6-scripts/account-script1.js
#echo "--------------------------------------------------------------------------------------"
#echo "Load testing with Grafana dashboard http://localhost:3000/d/k6/k6-load-testing-results"
for filename in k6-scripts/*.js; do
  docker-compose run -v $PWD:/telematicsct  k6 run --vus 200 --iterations 200 --duration 10m /telematicsct/k6-scripts/$(basename "$filename")
done

for filename in postman_collections/*.json; do
  postman-to-k6 $filename -o k6-scripts/$(basename "$filename-k6script.js") #/"$(basename "$filename-script.js")"
done

for filename in k6-scripts/*.js; do
  docker-compose run -v $PWD:/telematicsct  k6 run  /telematicsct/k6-scripts/$(basename "$filename")
done
