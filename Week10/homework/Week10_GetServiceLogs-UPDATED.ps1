function main {
    Write-Host "Week 10 - Get Service Logs Updated Assignment"
    Write-Host "Brendan McKenney"

    $choice = Read-Host -Prompt "Please type 'all', 'running', or 'stopped', or 'Q' to quit"


    if ($choice -match "all") {
            $allServices = Get-Service | Out-GridView
            Write-Host $allServices
            sleep 2
            main
    }
    if ($choice -match "running") {
            $runningServices = Get-Service | Where Status -EQ "Running" | Out-GridView
            Write-Host $runningServices
            sleep 2
            main
    
    }
    if ($choice -match "stopped") {
            $stoppedServices = Get-Service | Where Status -EQ "Stopped" | Out-GridView
            Write-Host $stoppedServices
            sleep 2 
            main 
    
    
    }

    if ($choice -match "^[qQ]$") {
            Write-Host "Thanks for using."
            break

    } else {
            Write-Host -BackgroundColor Red -ForegroundColor White "Unexpected value. Returning to main menu..."
            sleep 1
            main
    
    }



}
main