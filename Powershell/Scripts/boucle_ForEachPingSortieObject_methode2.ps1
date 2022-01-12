<#
    Pour chaque url 
    tester si elle répond au ping
    tester si le port 80 est ouvert
    tester si le port 443 est ouvert

    à la fin on veut renvoyer un objet personnalisé
#>

$TableauUrl = "www.google.fr", "www.m2iformation.fr", "je.nexiste.pas"
#definition collection au niveau du foreach
$CollectionRetour = foreach ($url in $TableauUrl){

    $ping = Test-connection $url -Count 1 -Quiet
    $port80 = Test-NetConnection $url -Port 80 -WarningAction SilentlyContinue
    $port443 = Test-NetConnection $url -Port 443 -WarningAction SilentlyContinue

    $objetRetour = [PSCustomObject]@{
        "url" = $url
        "Ping" = $ping
        "Port80" = $port80.TcpTestSucceeded
        "Port443" = $port443.TcpTestSucceeded
    }
    $objetRetour
}
$CollectionRetour