Get-Command "service"
Get-Command get*service*
#powershell organisé en bibliothèque
# chaque bibliothéque est disponible via un module
#liste de modules installés
Get-Module
#liste des modules disponibles
Get-Module -ListAvailable
Get-Command -module Hyper-V
# aide d'une commande
Get-Help New-VM
Get-Help New-VM -Examples
Get-help about*
Get-Help about_if
Get-date | Get-Member
$Today = Get-Date
$Today
cd /
ls

(get-date).AddMonths(2)
(Get-Command).count
#collection d'objets
Get-Service
Get-Service | Sort-Object Status, DisplayName
Get-Service | Where-Object Status -eq "Running"
Get-ChildItem | Where-Object LastWriteTime -gt (get-date).AddMonths(-1)
cd /
ls | Where-Object Length -gt 10mB | Sort-Object LastWriteTime | Export-Csv \test.csv -Delimiter ";" -Encoding Default -NoTypeInformation
ls | Where-Object Length -gt 10mB | Sort-Object LastWriteTime | Select-Object Name, Length, LastWriteTime, CreationTime | Export-Csv tilde\test.csv -Delimiter ";" -Encoding Default -NoTypeInformation
#bloc de script nécessaire
ls | Where-Object Length -gt 10MB -and LastWriteTime -eq 2022
#bloc de script
cd / | ls | Where-Object { $_.Length -gt 10MB}
# contexte diponibles Providers
Get-PSProvider
# Créer un tableau de 1 à 10
1..10
# pour forcer le bloc de script utilisation du ForEach-Object
# bloc de script indispensable pour utiliser $_
1..10 | ForEach-Object {$_ * 2}
1..10 | % {$_ * 2}
# test avec fichier ou.txt
cd ..
cat .\ou.txt
cat .\ou.txt | ForEach-Object{$Texte = $_; $texte.replace("OU=","")}
cat .\ou.txt | ForEach-Object{$Texte = $_; $texte.replace("OU=","").replace(",DC=form,DC=lan","")}
cat .\ou.txt | ForEach-Object{$Texte = $_; $texte.split(",")[0].replace("OU=","")}