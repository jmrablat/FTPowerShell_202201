# pour des infos complémentaires
# Get-Help ABOUT_FUNCTIONS_ADVANCED_PARAMETERSG

Param(
    # le paramètre est un tableau de string
    [Parameter(ValueFromPipeline = $true)]
    [String[]]
    $Dossiers = @("Test")
)
Begin{

}
Process {
    foreach ($UnDossier in $Dossiers) {
        try {
            #on rend l'erreur de type Terminating
            new-item c:\$UnDossier -ItemType Directory -ErrorAction Stop | Out-Null
        }
        catch {
            " une erreur !"
            Write-CustomLog -Message $_.exception.message -Type Erreur -Display
        }
        finally {
            "c'est fini"
        }
    }
}
End{

}