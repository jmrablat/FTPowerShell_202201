<#
    
    La boucle do While est un dérivé de la boucle While

    La particularité de la boucle do While est qu'elle teste la condition à la fin.
    Cela implique que de toutes façons, on passe toujours dans la boucle une fois


    do{

        Bloc de script

    }While(Condition(s))

#>

# On ouvre la boucle Do While
do{
    
    # On crée le menu
    "A - Vider le cache dns"
    "B - Tester la connectivité à Google"
    "C - Afficher mon adresse IP"
    "D - Quitter le script"

    # On demande à l'utilisateur sa réponse
    $Reponse = Read-Host "Entrez votre choix"

# Valider que la Reponse est soit A soit B soit C soit D
}While($Reponse -notmatch "^[a-d]$")

















