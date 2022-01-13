<#
    Afficher une ou plusieurs phrases qui contiennent les informations suivantes sur le fichier.txt
    Date de dernière modif
    Nb de lignes 
    Nb de mots
    Taille
    (Personne qui a créé le fichier)

#>

# Transformer ce script pour qu'il le fasse pour tous les fichiers txt de c:\powershell





$Infos = Get-Content C:\PowerShell\fichier.txt | Measure-Object -Line -Word -Character
$Prop = Get-Item C:\PowerShell\fichier.txt
$Owner = (Get-Acl C:\PowerShell\fichier.txt).Owner.Split("\")[1]
# "Le fichier {0} contient {1} lignes, {2} mots, {3} caractères et a été modifié le {4} par $Owner" -f $Prop.Name, $Infos.Lines,$Infos.Words,$Infos.Characters, $Prop.LastWriteTime

# Je veux plus une phrase mais maintenant un joli objet qui sort la même chose
[PsCustomObject]@{

    "Nom" = $Prop.Name
    "Lignes" = $Infos.Lines
    "Mots" = $Infos.Words
    "Caractères" = $Infos.Characters
    "Modifié le" = $Prop.LastWriteTime
    "Créé Par" = $Owner

}


