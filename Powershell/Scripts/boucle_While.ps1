<#

    une boucle pour exécuer plusieur fois un bloc de script
    la boucle while permet de tester une condition et d'exécuter un bloc de script tant qu'elle est vraie
    syntaxe: 
    while (condition){
        bloc de script
    }

#>
$Compteur = 1
# tant que le compteur est inférieur à 20
while($Compteur -lt 20){
    # on affiche le compteur
    "Le compteur vaut: $Compteur"
    $Compteur++
}
" A la fin, le compteur vaut $Compteur"
