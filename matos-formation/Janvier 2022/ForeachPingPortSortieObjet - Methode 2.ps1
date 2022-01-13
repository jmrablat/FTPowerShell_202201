<#

    On veut pour chaque URL :
    - Tester si elle répond au ping
    - Tester si le port 80 est ouvert
    - Tester si le port 443 est ouvert

    A la fin on veut renvoyer un objet personnalisé

#>

$TableauUrl = "www.google.fr","www.m2iformation.fr", "je.nexiste.pas"

# Pour chaque Url dans le tableau des url et on intercepte et on stocke tous les retours dans une collection
$CollectionRetour = foreach($Url in $TableauUrl){

    # On commence par faire les tests et stocker les résultats
    $Ping = Test-Connection $Url -Count 1 -Quiet
    $Port80 = Test-NetConnection $Url -Port 80 -WarningAction SilentlyContinue
    $Port443 = Test-NetConnection $Url -Port 443 -WarningAction SilentlyContinue

    $ObjetRetour = [PSCustomObject]@{
        
        "Url" = $Url
        "Ping" = $Ping
        "Port80" = $Port80.TcpTestSucceeded
        "Port443" = $Port443.TcpTestSucceeded
        # "Test" = "J'ai vraiment beaucoup de texte histoire de faire une valeur super grande"

    }

    # On drope l'objet dans le pipe
    $ObjetRetour

}

$CollectionRetour
