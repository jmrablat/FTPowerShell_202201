#$Test = 2.4 => Pour un nombre la condition est valide
#$Test = "Coucou" => Pareil
#$Test = Get-Service Spooler => Pareil pour les objets
#$Test = $true

#$Test = 0 => Pour 0 la condition n'est pas valide
#$Test = "" => Pareil pour les string vide
#$Test = $null => Pareil
$Test =$false

if($Test){

    "On passe dans le if"

}
else{

    "On passe dans le else"

}
