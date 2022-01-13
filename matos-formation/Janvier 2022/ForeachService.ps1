<#
    
    EXERCICE :

    Récupérer la liste des services
    Pour chaque service afficher une phrase du type :
    Le service NomDUService est démarré/arrêté en vert ou en rouge en fonction du status du service

#>

$ListeService = Get-Service

foreach($Service in $ListeService){

    if($Service.status -eq "Running"){

        Write-Host "Le service $($service.Name) est démarré" -ForegroundColor green

    }
    else{

        Write-Host "Le service $($service.Name) n'est pas démarré" -ForegroundColor red
    }

}


