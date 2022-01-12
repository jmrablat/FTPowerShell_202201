<#
    la boucle foreach permet de parcourir un tableau ou une collection d'objets
    elle déclare une variable qui va accueillir chaque élement de la collection
#>

$TableauUrl = "www.google.fr", "www.m2iformation.fr", "je.nexiste.pas"

foreach ($url in $TableauUrl){
    if (Test-Connection $url -Count 2 -Quiet){
        Write-Host " $url est ok au ping" -ForegroundColor Green
    } else {
        Write-Host " $url ne répond pas au ping" -ForegroundColor Red
    }
}