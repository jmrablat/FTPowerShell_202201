<#

    Une fonction sert à la réutilisabilité du code
    En powershell ça crée une nouvelle commande qui pourra être utilisée exactement comme les commandes natives de Powershell

    Le nom de la fonction n'est pas obligé de respecter le standard Powershell Verbe-Nom MAIS il vaut mieux le faire
    Parce que sinon on aura des avertissement quand on passera au module
    Le verbe doit être choisi dans la liste des verbes autorisés consultables via Get-Verb

    Syntaxe :

    function NomDeLaFonction (){

        Bloc de script

    }

    Syntaxe avec des paramètres simples
    function Write-Coucou ($Nom){

        Bloc de script qui peut utiliser $nom

    }

    Syntaxe avec des paramètres avancés
    function NomFonction{

        Param(

            [Options]
            [Type]
            $Parametre,

            [Autre Option]
            [Autre Type]
            $AutreParametre

        )

        Bloc de script


    }





#>

Function Write-Bonjour(){

    write-Host "Bonjour !"

}

function Write-Coucou($Nom){
    
    Write-Host "Coucou $Nom" -ForegroundColor Green

}

function Write-Salut{

    Param(

        # On va rendre le paramètre obligatoire
        [Parameter(Mandatory=$true)]
        [String]
        $Prenom

    )

    Write-Host "Salut $Prenom" -ForegroundColor Cyan

}
function Set-CustomRegKey{

    Param(

        [Parameter(Mandatory=$true)]
        [String]
        $Name,

        [String]
        $Value

    )

    $Log = "Set-CustomRegKey.log"

    Write-CustomLog -Fichier $Log -Message "Initialisation de la fonction."
    $Chemin = "HKLM:\SOFTWARE\Formation"
    
    Write-CustomLog -Fichier $Log -Message "Création de la propriété avec le nom $Name et la valeur $Value."
    # On crée la valeur de registre
    New-ItemProperty -Path $Chemin -Name $Name -Value $Value -PropertyType string | Out-Null

    Write-CustomLog -Fichier $Log -Message "Fin de la fonction."

}
function Write-CustomLog{
<#
.SYNOPSIS
    Cette fonction écrit dans des fichiers logs

.DESCRIPTION
    Cette fonction écrit dans des fichiers logs, les type et peut ou non les afficher en couleur

.PARAMETER Fichier
    Ce paramètre est le nom du fichier

.PARAMETER Message
    Le message qui doit être logué

.PARAMETER Type
    Le type du message

.PARAMETER Display
    S'il est présent on affiche le message

.EXAMPLE
    Write-CustomLog "Mon super message" -Type info -Display
    
    Ecrit le message dans le fichier par défaut et l'affiche

.EXAMPLE
    Write-CustomLog "Mon super message" -Type Error -fichier test.log

    Ecrit le message dans le fichier test.log de type erreur
#>
    Param(

        [String]
        $Fichier = "Default.log",    # On attribue une valeur par défaut au paramètre fichier

        [Parameter(
            Mandatory=$true,
            HelpMessage="Le message sous forme de string qui doit être écrit dans le log",
            Position=0
        )]
        [String]
        $Message,

        [ValidateSet("Info","Warning","Error")]
        [String]
        $Type = "Info",

        [Switch]
        $Display

    )

    # On déclare un emplacement où stocker les logs
    $Emplacement = "C:\Powerhell\Logs"

    # On construit le chemin complet
    $CheminComplet = Join-Path $Emplacement $Fichier

    $Maintenant = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $Message = "$Maintenant - $type - $message"

    # On met le message dans le fichier
    Add-Content -Path $CheminComplet -Value $Message

    if($Display){

        $Color = [PSCustomObject]@{
            "Info" = "White"
            "Warning" = "Yellow"   
            "Error" = "Red"
        }
        
        Write-Host $Message -ForegroundColor $Color.$Type

    }


}



