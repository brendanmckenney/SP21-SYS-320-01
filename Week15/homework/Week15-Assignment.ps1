# Storyline: Create a CSV file from the downloaded JSON file and only extract the: name, provider, url, and source_format data
        
$u = "https://raw.githubusercontent.com/MISP/MISP/2.4/app/files/feed-metadata/defaults.json"

# Download the file
Write-Host -BackgroundColor Red -ForegroundColor White "Downloading the required json file now... `n"
sleep 2
Write-Host -BackgroundColor Red -ForegroundColor White "File downloaded"
sleep 2
Invoke-WebRequest -Uri $u -OutFile "C:\Users\brend\Desktop\defaults.json"
Write-Host -BackgroundColor Red -ForegroundColor White "Parsing and saving files to the desktop...."
Write-Host -BackgroundColor Red -ForegroundColor White "DONE"
        
# Convert JSON file into Powershell object
$get_defaults = (Get-Content -Raw -Path "C:\Users\brend\Desktop\defaults.json" | `
ConvertFrom-Json) | select Feed

# CSV file 
$defaultsCSV = "C:\Users\brend\Desktop\defaults.csv"

# Headers for the CSV File
Set-Content -Value "`"name`",`"provider`",`"url`",`"source_format`"" $defaultsCSV


#Array to store the data
$theData = @()


# For-each loop that loops through every instance of "Feed" and pulls the below sections (name, provider, url, source_format)
foreach ($threat in $get_defaults.Feed) {
            
    #Org/domain Name 
    $name = $threat.name

    #Provider 
    $provider = $threat.provider

    # URL Data
    $url = $threat.url

    # Source_format data
    $source_format = $threat.source_format

    # format the CSV file/add the extracted content to the CSV file data array
    $theData += "`"$name`",`"$provider`",`"$url`",`"$source_format`"`n"

        
}
# Convert the array to a string and append to the CSV file
"$theData" | Add-Content -Path $defaultsCSV





