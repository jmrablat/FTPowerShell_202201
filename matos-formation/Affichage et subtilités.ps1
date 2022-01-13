<#
    Ceci est un bloc de commentaires entre les <# 
    Les commentaires sont des lignes qui ne seront pas exécutées
    
    Un script c'est un fichier texte qui possède l'extension .ps1
    Qui contient des instructions qui sont exécutées dans l'ordre où elles sont écrites

    Lors de l'exécution d'un script, le langage va d'abord parcourir tout le script pour vérifier que la syntaxe est correcte
    Et si elle est correcte, le script est exécuté

#>

# La commande Write-Host qui permet d'afficher du texte à la console
Write-Host "Je suis du texte affiché à la console."

# Elle permet de personnaliser l'affichage
Write-Host "Je suis un message fancy !" -ForegroundColor Green

# On drope du texte dans le pipe
"Je suis du texte laché dans le pipe !"

# On déclare une variable String
$Prenom = "Nicolas"

# On utilise une variable dans une chaine
Write-Host "Bonjour $Prenom !"
Write-Host 'Bonjour $Prenom !'

# Les variables ne sont pas interprétées dans les chaines de caractères entre ' tandisqu'elles le sont dans les chaines entre "

# On récupère le service spooler
$Spooler = Get-Service Spooler

# On veut afficher une phrase avec le displayname du service dedans
Write-Host "Le service en cours est : $Spooler.DisplayName."

# Par défaut les chaines de caractères n'accèdent pas aux propriétés et aux méthodes
# Si on veut y accéder il faut encadrer par $()
Write-Host "Le service en cours est : $($Spooler.DisplayName)."

# Même chose si on veut mettre des commandes dedans :
Write-Host "Aujourd'hui nous sommes le $(Get-Date -Format 'dddd dd MMMM yyyy') et il est $(Get-Date -Format 'HH:mm:ss')"

# Il exite une autre méthode pour mettre des commandes et des variables dans des chaines de caractère
# Mais elle ne fonctionne pas avec Write-Host mais seulement quand on lache du texte dans le pipe
# La méthode c'est -f

"Je m'appelle {0}" -f $Prenom

# On déclare une autre variable :
$Nom = "Bernard"

"Mon nom est {0} {1}" -f $Prenom, $Nom

# Et ca marche aussi pour les commandes
# L'avantage de cette méthode c'est qu'elle gère le formatage
"Aujourd'hui nous sommes le {0:dddd dd MMMM yyyy} et il est {0:HH:mm:ss}." -f (Get-Date)

