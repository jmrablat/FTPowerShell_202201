<#
    On peut créer ses propres objets avec les propriétés qu'on veut
    Syntaxe :

    $Objet = [PsCustomObject]@{

        "Propriété" = Valeur
        ...

    }
    
#>

# On crée un objet
$User1 = [PsCustomObject]@{

    "Nom" = "Bernard"
    "Prénom" = "Nicolas"
    "Age" = 24

}

# On lache l'objet dans le pipe
$User1

# On crée un objet
$User2 = [PsCustomObject]@{

    "Nom" = "Schim"
    "Prénom" = "Semin"
    "Age" = 40

}

# On lache l'objet dans le pipe
$User2



