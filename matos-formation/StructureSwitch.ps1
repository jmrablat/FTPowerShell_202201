<#
    
    La structure Switch
    C'est une structure d'aiguillage qui permet potentiellement de rentrer dans plusieurs blocs de script

    Syntaxe
    
    Switch ($VariableOuUnTableau){

        Valeur {
            
            Bloc de script

        }

        {Condition(s)} {

            Bloc de script

        }

        Default {

            Bloc de script qui sera exécuté si on est passé dans les blocs du dessus

        }

    }

#>

$Note = 20

switch($Note){

    20 {Write-Host "L'élève a eu la note maximale !!! GG !!!" -ForegroundColor Green}

    {$_ -ge 10} {

        Write-Host "L'élève est admis !!" -ForegroundColor Green

    }

    {$_ -ge 8 -and $_ -lt 10} {

        Write-Host "L'élève est à l'oral.." -ForegroundColor Yellow

    }

    Default {

        Write-Host "L'élève est recalé..." -ForegroundColor Gray

    }

}









