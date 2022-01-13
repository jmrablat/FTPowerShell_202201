<#
    
    
    


#>

function New-Histoire{
    
    Param(
        
        [Parameter(Mandatory = $true, HelpMessage = "Ben c'est le princesse hein...")]
        [String]
        $NomPrincesse,

        [String]
        $Pays = "imaginaire"

    )


    Write-Host "Il était une fois dans le pays $Pays la princesse $NomPrincesse dans un chateau..."

}



