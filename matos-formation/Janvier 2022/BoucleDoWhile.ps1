<#

    La boucle do While a sa condition à la fin du bloc de script
    Cela a pour effet d'exécuter le bloc au moins une fois

    Syntaxe :
    Do{

        Bloc de script

    }While(Condition(s))

#>

$Menu = @'
Quelle action voulez-vous effectuer ?
A - Action numéro 1
B - Une autre action numéro 2
C - Une super action 3
'@

$ReponsesPossibles = "a","b","c"

# Tant que le compteur est inférieur à 20
do{

    Write-Host $Menu

    # On demande à l'utilisateur de choisir l'action
    $Choix = Read-Host "Choix de l'action"
    
}While($Choix -notin $ReponsesPossibles)

Write-Host "L'utilisateur a choisi $Choix."