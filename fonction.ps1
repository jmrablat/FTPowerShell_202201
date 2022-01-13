#litse des verbs powershell
#Get-Verb
Function Write-Bonjour() {
    Write-Host "Bonjour"
}
# utilisation de la fonction en ligne de commande
#1..100 | % {Write-Bonjour}
Function Write-BonjourAvecParam($Nom) {
    Write-Host "Bonjour $Nom" -ForegroundColor Blue
}
# avec param évolué
Function Write-Salut {
    [CmdletBinding()]
    param( 
        [parameter(mandatory=$true)]     
        [string] $prenom
    )
    Write-Host "Salut $prenom" -ForegroundColor Blue
}
Function Set-CustomRegKey{
    param (
            [Parameter(Mandatory=$true)]
            [string]
            $Name,
            
            [string]
            $Value 
        )

    $Log = "Set-CustomRegKey.log"

    Write-CustomLog -Fichier $Log -Message "init"
    
    $Chemin = "HKLM:\SOFTWARE\Formation"
    Write-CustomLog -Fichier $Log -Message "Modification de la clé : $chemin"
    Write-CustomLog -Fichier $Log -Message "création de la propriété, avec le nom $Name et la valeur $Value"
    New-ItemProperty -Path $Chemin -Nam $Name -Value $Value -PropertyType string | Out-Null
    Write-CustomLog -Fichier $Log -Message "--> OK propriété créée"
}
#créer une entrée dans la base des regsitres
#New-item HKLM:\SOFTWARE\Formation
Function Write-CustomLog{
<#
.SYNOPSIS
    Cette fonction blablabla
.DESCRIPTION
    Elle fait blablabla
.PARAMETER Fichier
    LE nom du fichier
.PARAMETER Type
    Le type du message
.PARAMETER Display
    Le message doit être affiché dans la console
.EXAMPLE
    Write-CustomLog "avec type de message en plus" -Type Erreur -Display
.EXAMPLE
    Write-CustomLog "avec type de message en plus" -Display



#>
    Param(
        [string]
        $Fichier = "Default.log",
        [Parameter(
            Mandatory=$true,
            Position=0, 
            HelpMessage="Le message à renseigner pour alimenter le fichier de log")] #pour afficher l'aide en ligne de commande : !?
        [string]
        $Message,
        [ValidateSet("Info","Warning","Erreur")]
        [string]
        $Type = "Info",
        
        [Switch]
        $Display
    )
    $Emplacement = "C:\Users\Administrateur\formationPS\Powershell\Logs"
    $CheminComplet = Join-Path $Emplacement $Fichier
    $Maintenant = Get-Date -Format "yyy/MM/dd HH:mm:ss"

    $Log = "$Maintenant - $Type - $Message"

    Add-Content -Path $CheminComplet -value $Log

    if($Display){

        $Color = [PSCustomObject]@{
            "Info" = "blue"
            "Warning" = "Yellow"
            "Erreur" = "Red"
        }

        write-host $Log -ForegroundColor $Color.$Type
    }
}