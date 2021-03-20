# Storyline: Review the Security Event Log

# Directory to ave files
$myDir = "C:\Users\brend\Desktop\"

# List all the available Windows Events logs
Get-EventLog -List 

# Create a prompt to allow user to select the log to view
$readLog = Read-Host -Prompt "Please select a log to review from the list above"

# Create a prompt to ask the user what the specified logs should be searched by.
$readPhrase = Read-Host -Prompt "What keyword or phrase should be searched for in the log? (If none hit enter)"

# Print the results for the log
Get-EventLog -LogName $readLog -Newest 40 | where {$_.Message -ilike "*$readPhrase*"} | Export-Csv -NoTypeInformation `
-Path "$myDir\securityLogs.csv"


# Task: Create a prompt that allows the usr to specifiy a keyword or phrase to seach on. (SHOWN ABOVE)