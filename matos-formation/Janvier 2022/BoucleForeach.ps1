<#

    La boucle foreach permet de parcourir un tableau ou une collection d'objets
    Elle déclare une variable qui va accueillir chaque élément de la collection et s'en servir dans le bloc de script

    Syntaxe : 
    foreach($Element in $CollectionOuTableau){

        Bloc de script qui utilise $Element

    }

#>

$TableauUrl = "www.google.fr","www.m2iformation.fr", "je.nexiste.pas"

# Pour chaque Url dans le tableau des url
foreach($Url in $TableauUrl){

    if(Test-Connection $Url -Count 2 -Quiet){

        Write-Host "$Url répond au ping !" -ForegroundColor Green

    }
    else{

        Write-Host "$Url ne répond pas au ping !" -ForegroundColor Gray

    }

}


