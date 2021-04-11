# Storyline: Incident response toolkit that retrieves a variety of information and can be optionally saved
function checkDir() {
    # Testing to see if destination folder exists before attempting to create data within it
    $Folder = 'C:\Users\brend\Desktop\IncidentResponseToolkit_Results'
    if (Test-Path -Path $Folder) {
        "Checking to see if destination folder exists... DONE"
    } else {
        # Creating destination folder if it does not exists"
        "Checking destination to see if it exists... FAILED"
        "Creating destination folder 'IncidentResponseToolkit_Results' in desktop now... "
        New-Item -Path 'C:\Users\brend\Desktop\IncidentResponseToolkit_Results' -ItemType Directory
        "**DONE** Opening menu..."
    }


}
function setDir() {
     $global:readDir = Read-Host -Prompt "**This menu is used to capture and save data about the local system to the users computer. What destination would you like to save these files to? (MUST BE IN SYSTEM PATH FORMAT)"

     if (Test-Path -Path $global:readDir) {
         "Checking to see if destination folder exists... DONE"
     } else {
         "Checking destination folder to see if it exists...FAILED"
         "Creating specified destination directory now..."
         New-Item -Path $global:readDir -ItemType Directory
     
     }
}
setDir
function menu() {
    do {
    Write-Host "`n============= Incident Response Toolkit Menu=============="
    Write-Host "`nChoose one of the options below:"
    Write-Host "`t1. List running processes and the path for each process"
    Write-Host "`t2. List all registered services and the executable's path"
    Write-Host "`t3. List all tcp network sockets"
    Write-Host "`t4. List all user account information"
    Write-Host "`t5. List all NetworkAdapterConfiguration information"
    Write-Host "`t6. Get the Event Log of the system"
    Write-Host "`t7. List all of the services installed on the system"
    Write-Host "`t8. Get the execution policies for the current session"
    Write-Host "`t9. Get list of hotfixes that have been applied to the system"
    Write-Host "`t10. Create checksum csv file that contains checksums of all files in the destination folder"
    Write-Host "`t11. Create .zip file of data folder and create checksum of .zip file/save it to a file"
    Write-Host "`t12. Type 'q' to Quit"
    Write-Host "========================================================"
    $choice = Read-Host "`nEnter Choice"
    } until (($choice -eq '1') -or ($choice -eq '2') -or ($choice -eq '3') -or ($choice -eq '4') -or ($choice -eq '5') -or ($choice -eq '6') -or ($choice -eq '7') -or ($choice -eq '8') -or ($choice -eq '9') -or ($choice -eq '10' ) -or ($choice -eq '11' ) -or ($choice -eq 'q' ) )
    switch ($choice) {
       '1'{
           Write-Host "`nListing running processes and their paths..."
           sleep 1
           $runningProcess = Get-Process | select Name, Path
           $runningProcess | Out-Host
           sleep 1
           # Return to main menu when 'm' key is press
           $readKey = Read-Host -Prompt "Would you like to save these results to a .csv file?"
           
           

           if ($readKey -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to your desktop.."
                   sleep 2
                   $runningP2rocess | Export-Csv -Path $readDir\processes.csv
                   Write-Host "Data has been saved."
           
           }
       menu
       }
       '2'{
          Write-Host "`nListing all registered services and the executable's path."
          sleep 1
          $services = Get-WmiObject win32_service | select Name, PathName
          $services | Out-Host
          sleep 1

          $readKey = Read-Host -Prompt "Would you like to save these results to a .csv file?"

           if ($readKey -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 2
                   $services | Export-Csv -Path $readDir\services.csv
                   Write-Host "Data has been saved."
           
           }
       menu
       }
       '3'{
           Write-Host "`nListing all of the tcp network sockets..."
           sleep 2
           $tcpSockets = Get-NetTCPConnection
           $tcpSockets | Out-Host
           sleep 1

           $readKey = Read-Host -Prompt "Would you like to save these results to a .csv file?"

           if ($readKey -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 2
                   $tcpSockets | Export-Csv -Path $readDir\tcpsockets.csv
                   Write-Host "Data has been saved."
           
           }
        menu
        }
        '4'{
           Write-Host "`nListing all user account information..."
           sleep 2
           $userInfo = Get-LocalUser
           $userInfo | Out-Host
           sleep 1

           $readKey = Read-Host -Prompt "Would you like to save these results to a .csv file?"

           if ($readKey -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 2
                   $userInfo | Export-Csv -Path $readDir\userinfo.csv
                   Write-Host "Data has been saved."
           
           }
        menu
        }
        '5'{
           Write-Host "`nListing visible network adapter information..."
           sleep 2
           $netAdapter = Get-NetAdapter -Name *
           $netAdapter | Out-Host
           sleep 1

           $readKey = Read-Host -Prompt "Would you like to save these results to a .csv file?"

           if ($readKey -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 2
                   $netAdapter | Export-Csv -Path $readDir\netadapterinfo.csv
                   Write-Host "Data has been saved."
                   sleep 2
           
           }
        menu
        }
        '6'{
           Write-Host "`nGetting the system event log of the local system..."
           sleep 2
           $eventLog = Get-EventLog -LogName System -Newest 10
           $eventLog | Out-Host
           sleep 1

           $readKey = Read-Host -Prompt "Would you like to save these results to a .csv file?"

           if ($readKey -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 2
                   $eventLog | Export-Csv -Path $readDir\systemeventlog.csv
                   Write-Host "Data has been saved."
                   sleep 2
           
           }
        menu
        }
        '7'{
           Write-Host "`nListing all services installed on the system..."
           sleep 2
           $services2 = Get-WmiObject win32_service | select Name
           $services2 | Out-Host
           sleep 1

           $readKey = Read-Host -Prompt "Would you like to save these results to a .csv file?"

           if ($readKey -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 2
                   $services2 | Export-Csv -Path $readDir\all_services.csv
                   Write-Host "Data has been saved."
                   sleep 2
           
           }
        menu
        }
        '8'{
           Write-Host "`nGetting the execution policies for this session..."
           sleep 2
           $executionPolicy = Get-ExecutionPolicy -List
           $executionPolicy | Out-Host
           sleep 1

           $readKey = Read-Host -Prompt "Would you like to save these results to a .csv file?"

           if ($readKey -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 2
                   $executionPolicy | Export-Csv -Path $readDir\executionPolicies.csv
                   Write-Host "Data has been saved."
                   sleep 2
           
           }
        menu
        }
        '9'{
           Write-Host "`nGetting the hotfixes that have been applied to this system..."
           sleep 2
           $getHotfix = Get-Hotfix
           $getHotfix | Out-Host
           sleep 1

           $readKey = Read-Host -Prompt "Would you like to save these results to a .csv file?"

           if ($readKey -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 2
                   $getHotfix | Export-Csv -Path $readDir\hotfixes.csv
                   Write-Host "Data has been saved."
                   sleep 2
           
           }
        menu
        }
        '10'{
            Write-Host "**This feature will not work if there are no files in the destination folder.**"
            sleep 2
            $readY = Read-Host -Prompt "Find checksums of each file in the folder and save to a new file?"

            if ($readY -match "^[yY]$") {
                    Write-Host "Creating checksums for each existing file in the folder..."
                    sleep 2
                    $checkSums = Get-FileHash -Algorithm MD5 -Path (Get-ChildItem $readDir\*.*)
                    $checkSums | Export-Csv -Path $readDir\checksums.csv
                    Write-Host "File containing checksums has been created in the folder"
            
            }
            
        menu
        }
        '11'{
            Write-Host "**This feature will not work if there are no files in the target folder.**"
            sleep 2
            $readY = Read-Host -Prompt "Do you want to create a .zip file of the folder containing the system data and find checksum of the zip file?"

            if ($readY -match "^[yY]$") {
                    $zipdir = Read-Host -Prompt "What directory would you like the zip file saved to?"
                    Write-Host "Creating .zip file using Incident Response Toolkit data folder..."
                    sleep 2
                    Compress-Archive -Path $global:readDir -DestinationPath $zipdir\IncidentResponseToolkit_DATA
                    Write-Host ".Zip file created. Now finding checksum for the .zip file and saving it to a file on the desktop..."
                    sleep 2
                    $checkSumDir = Read-Host -Prompt "What directory would you like the checksum file saved to?"
                    $zipcheck = Get-FileHash -path $zipdir\IncidentResponseToolkit_DATA.zip
                    $zipcheck | Export-Csv -Path $checkSumDir\IncidentResponseZIPCHECKSUM.csv
                    Write-Host "New .zip file and checksum successfully created. Checksum is located at: C:\Users\brend\Desktop\IncidentResponseZIPCHECKSUM.csv"
            
            }
            
        menu
        }
        'Q'{
          Write-Host "Thanks for using."
          break
       }
    }

}
menu