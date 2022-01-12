$ListeServices = Get-Service
foreach($service in $ListeServices){
    if ($service.Status -eq "Running") {
        Write-Host "Le service $($service.Name) est en cours " -ForegroundColor Green
    }
    else {
        Write-Host "Le service $($service.Name) n'est pas en cours " -ForegroundColor Red
    }
}