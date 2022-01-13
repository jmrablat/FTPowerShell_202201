# Tant que le ping répond
while(Test-Connection www.google.fr -Count 2 -Quiet){

    # On vide l'écran
    Clear-Host

    # On affiche qu'on a internet
    Write-Host "On a Internet ! " -ForegroundColor Green

}

Write-Host "On a plus internet" -ForegroundColor Gray


