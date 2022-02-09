
# installation-process

**Step 1.** Make sure that docker desktop is installed on your system. For mac visit : https://docs.docker.com/desktop/mac/install/

**Step 2.** Open the terminal from the root folder and run the following bash script 

user$ ./installer.sh

Make sure that the postman-collections scripts which are about to be load tested are stored in the postman_collections folder before running the above command.After running this command, postman-to-k6 converter is installed and a directory k6-scripts is created where postman-to-k6 scripts are stored. Grafana and InfluxDb services will be up and running. Every postman-collection json files will be stored in the postman_collections folder which are converted into k6 scripts in k6-script directory. Then k6 is initiated where every converted k6 script is load tested. The bash script also deletes the k6-scripts towards the end of the execution.

# Viewing the results

**Step 3.**  To view the results please visit "http://localhost:3000/d/XKhgaUpik/k6-load-testing-results" . The relative time range is set to 3 hours, you could change this to the nearest time range for better representation of the results on grafana (Example: Last 15minutes). The time range is situated towards the top right corner of the webpage. 
