<#

    On veut sortir une phrase par fichier qui dit "il y a x erreurs, y warninhg et z informations dans le fichier nomdufichier"
    
    Récupérer les fichiers txt

    Pour chaque fichier dans la liste des fichiers

        Récupérer le contenu du fichier

        On filtre le contenu du fichier sur les error // Une fois qu'on les a on les compte et on stocke le nombre
        Idem pour les warning
        Idem pour les information

        Afficher la phrase

#>

$CollFichiers = Get-ChildItem C:\PowerShell\*.txt

foreach($Fichier in $CollFichiers){

    $Contenu = Get-Content $Fichier

    $NbError = ($Contenu | ? {$_ -like "*error*"}).Count
    $NbWarning = ($Contenu | ? {$_ -like "*warning*"}).Count
    $NbInfo = ($Contenu | ? {$_ -like "*information*"}).Count


    $Retour = [PsCustomObject]@{
        
        "Fichier" = $Fichier.Name
        "NbErreurs" = $NbError
        "NbWarning" = $NbWarning
        "NbInfo" = $NbInfo 

    }

    $Retour

}

