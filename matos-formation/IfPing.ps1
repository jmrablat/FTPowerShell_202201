<#

    If peut accepter à peu près tout et n'importe quoi comme conditions


#>
if(Test-Connection 8.8.8.8 -Count 2 -Quiet){

    Write-Host "On a Internet !!!" -ForegroundColor Green

}
else{
    
    Write-Host "On a pas internet !" -ForegroundColor Gray

}


