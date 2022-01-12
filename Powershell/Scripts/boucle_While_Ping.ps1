# ajouter -Quiet permet à la commande de renvoyer true ou false à la place d'une erreur ou d'un résultat de ping
#Test-Connection www.google.fr -Count 2 -Quiet
$test = Test-Connection www.google.fr -Count 2 -Quiet
While ($test){
    Clear-Host
    Write-Host " on a Internet!" -ForegroundColor Green
    $test = Test-Connection www.google.fr2 -Count 2 -Quiet
}
Write-Host " on a plus Internet!" -ForegroundColor Red

