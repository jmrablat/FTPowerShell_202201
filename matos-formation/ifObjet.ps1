# On récupère un objet 
$Vol = Get-Volume -DriveLetter c

if($vol){

    Write-Host "J'ai un volume !"

}
else{
    
    Write-Host "J'ai pas de volume !"

}