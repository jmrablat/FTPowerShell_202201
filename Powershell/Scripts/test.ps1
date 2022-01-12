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
ls | Where-Object Length -gt 10mB | Sort-Object LastWriteTime