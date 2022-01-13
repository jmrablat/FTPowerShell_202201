<#

    La boucle While permet d'exécuter un bloc de script tant qu'une condition est vraie

    While(Condition(s)){
        
        Bloc de script

    }

#>

$Compteur = 0

# Tant que le compteur est inférieur à 10
While($Compteur -lt 10){

    Write-Host "Le compteur vaut : $Compteur"

    # On incrémente le compteur
    $Compteur++

    # On fait une petite pause
    Start-Sleep -Milliseconds 200
}

"La boucle est finie !"
"A la fin le compteur vaut $Compteur"

