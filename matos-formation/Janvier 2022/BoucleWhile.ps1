<#

    Une boucle ça permet d'exécuter plusieurs fois un bloc de script
    la boucle While permet de tester une condition et d'exécuter son bloc de script tant qu'elle est vraie

    Syntaxe :
    While(Condition(s)){

        Bloc de script

    }



#>

$Compteur = 156

# Tant que le compteur est inférieur à 20
While($Compteur -lt 20){

    # On affiche le compteur
    "Le compteur vaut : $compteur"

    # On incrémente le compteur
    $Compteur++

}

"A la fin, le compteur vaut : $Compteur"




