# Wait for localhost:8088 to be ready
$timeout = 200
$stopWatch = [System.Diagnostics.Stopwatch]::StartNew()
while ($true) {
    try {
        $response = Invoke-WebRequest -Uri http://localhost:8088 -UseBasicParsing -TimeoutSec 5
        if ($response.StatusCode -eq 200) {
            break
        }
    } catch {
        Start-Sleep -Seconds 1
    }

    if ($stopWatch.Elapsed.TotalSeconds -ge $timeout) {
        Write-Host "Timeout reached, exiting..."
        exit 1
    }
}

# POST request with JSON data
Invoke-RestMethod -Method Post -Uri http://localhost:8088/fhir -ContentType "application/json" -InFile "./data_files/gs_patients.json"
Invoke-RestMethod -Method Post -Uri http://localhost:8088/fhir -ContentType "application/json" -InFile "./data_files/gs_observations.json"

# Wait for user input to exit
Read-Host -Prompt "Press any key to exit..."