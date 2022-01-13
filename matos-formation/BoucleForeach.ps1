<#
    
    La boucle foreach
    La boucle foreach prends en entrée un tableau ou une collection d'objets et 
    son bloc de script est exécuté autant de fois qu'il y a d'éléments dans le tableau ou la collection

    foreach( $Element in $TableauOuCollection ){

        Bloc de script qui peut utiliser la variable $Element

    }

#>

# On va déclarer un tableau d'url
$CollURL = "www.google.fr", "www.groupe-arkesys.com", "www.meteo.fr","je.nexiste.pas"

# Pour chaque Url dans le tableau des url
foreach($Url in $CollURL){
    
    # Si le ping répond
    if(Test-Connection $Url -Count 2 -Quiet){

        Write-Host "$Url répond au ping !" -ForegroundColor Green

    }
    else{
        
        Write-Host "$url ne répond pas au ping !" -ForegroundColor Gray

    }

}