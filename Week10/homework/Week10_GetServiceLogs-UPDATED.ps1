function main {
    Write-Host "Week 10 - Get Service Logs Updated Assignment"
    Write-Host "Brendan McKenney"

    $choice = Read-Host -Prompt "Please type 'all', 'running', or 'stopped', or 'Q' to quit"


    if ($choice -match "all") {
            Get-Service | Out-Host
            
            sleep 2
            main
    }
    if ($choice -match "running") {
            Get-Service | Where { $_.Status -eq "Running" } | Out-Host
            sleep 2
            main
    
    }
    if ($choice -match "stopped") {
            Get-Service | Where {$_.Status -eq "Stopped" } | Out-Host
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