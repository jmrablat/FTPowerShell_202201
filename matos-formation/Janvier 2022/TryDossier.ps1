
Param(
    # le paramètre est un tableau de string
    [Parameter(ValueFromPipeline=$true)]
    [String[]]
    $Dossier = @("Test")

)
Begin{

}
Process{
    foreach($Element in $Dossier){

        Try{

            # On rend l'erreur terminating
            New-Item "c:\$Element" -ItemType Directory -ErrorAction Stop | Out-Null

        }
        catch{

            Write-CustomLog -message  $_.exception.message -Type Error -Display

        }

    }
}
end{

    
}