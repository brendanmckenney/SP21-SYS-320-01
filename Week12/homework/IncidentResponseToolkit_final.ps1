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
    Write-Host "`t10. Gather ALL information and save to destination directory"
    Write-Host "`t11. Create checksum csv file that contains checksums of all existing files in the destination folder"
    Write-Host "`t12. Create .zip file of data folder and create checksum of .zip file/save it to a file"
    Write-Host "`t13. Transfer destination folder to host using SCP"
    Write-Host "`t14. Type 'q' to Quit"
    Write-Host "========================================================"
    $choice = Read-Host "`nEnter Choice"
    } until (($choice -eq '1') -or ($choice -eq '2') -or ($choice -eq '3') -or ($choice -eq '4') -or ($choice -eq '5') -or ($choice -eq '6') -or ($choice -eq '7') -or ($choice -eq '8') -or ($choice -eq '9') -or ($choice -eq '10' ) -or ($choice -eq '11' ) -or ($choice -eq '12' ) -or ($choice -eq '13' ) -or ($choice -eq 'q' ) )
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

            # Defining variables for each of the data collection methods.
            $getHotfix = Get-Hotfix
            $executionPolicy = Get-ExecutionPolicy -List
            $services2 = Get-WmiObject win32_service | select Name
            $eventLog = Get-EventLog -LogName System -Newest 10
            $netAdapter = Get-NetAdapter -Name *
            $userInfo = Get-LocalUser
            $tcpSockets = Get-NetTCPConnection
            $services = Get-WmiObject win32_service | select Name, PathName
            $runningProcess = Get-Process | select Name, Path


            Write-Host "This feature will perform all data collection tasks at once and output to the destination directory."
            $readY = Read-Host -Prompt "Would you like to continue?"

            if ($readY -match "^[yY]$") {
                    Write-Host -ForegroundColor Red "*Collecting and saving data to destination directory... This could take a minute."
                    sleep 2
                    $getHotfix | Export-Csv -Path $readDir\hotfixes.csv
                    $executionPolicy | Export-Csv -Path $readDir\executionPolicies.csv
                    $services2 | Export-Csv -Path $readDir\all_services.csv
                    $eventLog | Export-Csv -Path $readDir\systemeventlog.csv
                    $netAdapter | Export-Csv -Path $readDir\netadapterinfo.csv
                    $userInfo | Export-Csv -Path $readDir\userinfo.csv
                    $tcpSockets | Export-Csv -Path $readDir\tcpsockets.csv
                    $services | Export-Csv -Path $readDir\services.csv
                    $runningProcess | Export-Csv -Path $readDir\processes.csv
                    Test-Path -Path $global:readDir
                    Write-Host -ForegroundColor Red "Data collected and saved successfully."
                    sleep 2
            }

  
        menu
        }
        '11'{
            Write-Host "**This feature will not work if there are no files in the destination directory.**"
            sleep 2
            $readY = Read-Host -Prompt "Find checksums of each file in the directory and save to a new file?"

            if ($readY -match "^[yY]$") {
                    Write-Host "Creating checksums for each existing file in the destination directory..."
                    sleep 2
                    $checkSums = Get-FileHash -Algorithm MD5 -Path (Get-ChildItem $readDir\*.*)
                    $checkSums | Export-Csv -Path $readDir\checksums.csv
                    Write-Host -ForegroundColor Red "File containing checksums has been created in the destination directory."
                    sleep 2
            
            }
            
        menu
        }
        '12'{
            Write-Host "**This feature will not work if there are no files in the target folder.**"
            sleep 2
            $readY = Read-Host -Prompt "Do you want to create a .zip file of the folder containing the system data and find checksum of the zip file?"

            if ($readY -match "^[yY]$") {
                    $zipdir = Read-Host -Prompt "What directory would you like the zip file saved to?"
                    Write-Host -ForegroundColor Red "Creating .zip file using Incident Response Toolkit data folder..."
                    sleep 2
                    Compress-Archive -Path $global:readDir -DestinationPath $zipdir\IncidentResponseToolkit_DATA-McKenney
                    Write-Host ".Zip file created. Now finding checksum for the .zip file and saving it to a file on the desktop..."
                    sleep 2
                    $checkSumDir = Read-Host -Prompt "What directory would you like the checksum file saved to?"
                    $zipcheck = Get-FileHash -path $zipdir\IncidentResponseToolkit_DATA-McKenney.zip
                    $zipcheck | Export-Csv -Path $checkSumDir\IncidentResponseZIPCHECKSUM.csv
                    sleep 1
                    Write-Host -ForegroundColor Red "New .zip file and checksum successfully created. Checksum is located at: C:\Users\brend\Desktop\IncidentResponseZIPCHECKSUM.csv"
                    sleep 2
            
            }
            
        menu
        }
        '13'{
            $readSCP = Read-Host -Prompt "Transfer zip file to champlain system for Week 12 assignment?"
            
            if ($readSCP -match "^[yY]$") {
                    New-SSHSession -ComputerName '192.168.4.50' -Credential (Get-Credential brendan.mckenney@cyber.local)
                    Set-SCPFile -ComputerName '192.168.4.50' -Credential (Get-Credential brendan.mckenney@cyber.local) -RemotePath '/home/brendan.mckenney@cyber.local' -LocalFile 'C:\Users\brend\Desktop\IncidentResponseToolkit_DATA-McKenney.zip'
                    Invoke-SSHCommand -index 0 'ls -l'
                    sleep 2
                    Remove-SSHSession -SessionId 0
                    Write-Host -ForegroundColor Red "Destination folder transfer successful and SSH session closed."
                    sleep 2
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