<#
.SYNOPSIS
    Cette fonction écrit des log.

.DESCRIPTION
    Cette fonction écrit des log dans des fichiers texte et peut ou non les afficher à la console.

.PARAMETER Fichier
    Est le nom du fichier log dans lequel écrire.

.PARAMETER Message
    Est le texte que l'on veut écrire dans le fichier.

.PARAMETER Type
    Peut être soit Error,Warning ou Info.

.PARAMETER Display
    S'il est passé, le message est affiché à la console.

.EXAMPLE
    Write-CustomLog -Message "Coucou"

    Ecrit Coucou dans Default.log.

.EXAMPLE
    Write-CustomLog -Message "Coucou" -Fichier Test.log.

    Ecrit Coucou dans test.log

.EXAMPLE
    Write-CustomLog -Message "Coucou" -Fichier Test.log -Type Error

    Ecrit Coucou dans test.log et type le message en erreur.

.EXAMPLE
    Write-CustomLog -Message "Coucou" -Fichier Test.log -Type Error -Display

    Ecrit Coucou dans test.log et type le message en erreur et l'affiche à la console.

#>

Param(
    
    [Parameter(ValueFromPipeline = $true)]
    [String[]]
    $Name = "<Insert Name Here>"

)

$Adjectif = Get-Random ("merveilleux","fantastique", "génial","extravagant", "chiant", "pète burne")


Write-Host "Je voulais te dire, $name, que je te trouve vraiment $Adjectif !"
