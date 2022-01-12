<#
La boucle do while a sa condition à la fin du bloc de script
cela a pour effet d'exécuter le bloc au moins 1 fois
Syntaxe:
Do {

}While(Condition(s))
#>
$Menu= @'
Quelle action voulez-vous effectuer ?
A - Action numéro 1
B - une autre action
C - Rien?
'@
$ReponsesPossibles = "a", "b", "c"
do{
    Write-Host $Menu
    # on demande à l'utilisateur de répondre
    $Choix = Read-Host "Choix de l'action: "
}while($Choix -notin $ReponsesPossibles)
Write-Host "choix de l'utilsateur : $Choix"