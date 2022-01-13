<#

    Récupérer les fichier txt dans le dossier c:\Powershell

    Pour chaque fichier

        Récupérer le contenu 

        Stocker ce contenu dans un fichier compilation.txt

        Déplacer le fichier dans le dossier Archive

#>

$CollFichiers = Get-ChildItem C:\PowerShell\*.txt

foreach($Fichier in $CollFichiers){

    $Contenu = Get-Content $Fichier

    Add-Content -Path .\compilation.txt -Value $Contenu

    Move-Item -Path $Fichier -Destination .\Archive


}




