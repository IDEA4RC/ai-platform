./wait-for-it.sh localhost:8088 --timeout=200
curl -X POST -H "Content-Type: application/json" -d @./data_files/gs_patients.json http://localhost:8088/fhir
curl -X POST -H "Content-Type: application/json" -d @./data_files/gs_observations.json http://localhost:8088/fhir
read -p "Press any key to exit..."