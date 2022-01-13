<#
    
    Les fonctions permettent de réutiliser le code à plusieurs endroits
    En powerShell elles créent des commandes

    Syntaxe :

    function NomFonction {

        Param(
            
            $Parametre1,

            Parametre2

        )

    }

    Le nom de la fonction n'est pas obligé de respecter la norme des commandes powershell
    MAIS IL VAUT MIEUX LA RESPECTER SINON ON VA PRENDRE DES AVERTISSEMENTS PLUS TARD !!!!

    La norme des commandes c'est Verbe-Nom ou verbe-LeTrucQueJeVeux
    Pour savoir quels verbes on a le droit d'utiliser : Get-Verb

#>
# On déclare une fonction qui s'appelle Write-Bonjour
function Write-Bonjour{

    # On affiche bonjour
    Write-Host "Bonjour !"

}
<#

    Transformer la fonction write-Coucou pour qu'elle puisse dire Coucou à plusieurs personnes
    Ces noms peuvent être donnés avec le paramètre -Name ou être envoyés depuis le pipe

#>
function Write-Coucou{
    
    # On déclare un bloc de paramètres
    Param(
        
        # La fonction prendra un paramètre Name
        [Parameter(Mandatory=$true,ValueFromPipeline = $true)]
        [String[]]
        $Name

    )
    Process{
        
        foreach($Nom in $Name){

            Write-Host "Coucou $Nom !"

        }

    }

}
function Write-Salut {

    Param(
        
        $Nom,

        $Prenom

    )

    Write-Host "Salut $Prenom $Nom !"

}

# Créer une fonction qui s'appelle Test-Ping qui prend en paramètre un ComputerName
# Qui renvoie une phrase en vert si le ping a réussi et en rouge s'il n'a pas réussi
function Test-Ping {
    
    Param(
        
        [String[]]                   # On dit que le paramètre sera un tableau de string
        $ComputerName = "8.8.8.8"    # Le paramètre a la valeur par défaut 8.8.8.8

    )


    # Pour chaque computer dans computername
    foreach($Computer in $ComputerName){

        if(Test-Connection $Computer -Count 2 -Quiet){

            Write-Host "$Computer répond." -ForegroundColor Green
        }
        else{

            Write-Host "$Computer ne répond pas." -ForegroundColor Gray

        }

    }

}
function Test-Connectivity {
    
    Param(
        
        [String[]]                   # On dit que le paramètre sera un tableau de string
        $ComputerName = "8.8.8.8"    # Le paramètre a la valeur par défaut 8.8.8.8

    )


    # Pour chaque computer dans computername
    foreach($Computer in $ComputerName){
        
        # On crée un objet pour stocker les infos
        $Retour = [PSCustomObject]@{

            "Hote" = $Computer
            "Ping" = Test-Connection $Computer -Count 2 -Quiet
            "Port 80" = Test-NetConnection $Computer -port 80 -InformationLevel Quiet -WarningAction SilentlyContinue
            "Port 443" = Test-NetConnection $Computer -port 443 -InformationLevel Quiet -WarningAction SilentlyContinue

        }

        # On drope l'objet dans le pipe
        $Retour

    }

}
<#
    Créer une nouvelle fonction qui s'appelle Set-RegKey

    Elle prend en paramètre Name et Value

    Elle crée une propriété dans le registre dans la clef hklm:\software\Formation 
    avec pour Nom Name et Valeur Value

    Mais si jamais elle existe déjà, on remplace la valeur par la nouvelle valeur

    La fonction donne beaucoup d'indication à l'utilisateur via des write-host
    Du genre "Initialisation de la fonction avec les valeurs blabalal", création de la propriété...

#>
function Set-RegKey{

    Param(
        
        [Parameter(Mandatory = $true)] # On rend le paramètre obligatoire
        [String]
        $Name,

        [String]
        $Value,

        [ValidateSet("HKLM","HKCU")]
        [String]
        $Ruche = "HKLM"
    )

    $FichierLog = "Set-RegKey.log"


    Write-CustomLog -Fichier $FichierLog -Type Info -Message "Initialisation de la fonction Set-Regkey avec Name : $Name et Value : $Value dans la ruche : $Ruche."

    # On donne le chemin de la clef
    $Chemin = "$($ruche):\SOFTWARE\Formation"

    # On récupère les propriétés du chemin
    $RegVar = Get-ItemProperty -Path $Chemin -Name $Name -ErrorAction SilentlyContinue

    # Si la variable n'est pas nulle
    if($RegVar){
        
        Write-CustomLog -Fichier $FichierLog -Type Warning -Message  "La propriété existe déjà." -Display
        
        # On demande à l'utilisateur s'il veut écraser la clef
        do{

            $Reponse = Read-Host "Voulez-vous écraser la propriété ? (O)ui/(N)on/(A)nnuler"

        }while($Reponse -notin "o","n","a")

        if($Reponse -eq "o"){

            # On modifie la propriété
            Set-ItemProperty -Path $Chemin -Name $Name -Value $Value

            Write-CustomLog -Fichier $FichierLog -Type Info -Message  "Modification de la propriété $Name avec la nouvelle valeur : $Value."
        }
        else{
            
            Write-CustomLog -Fichier $FichierLog -Type Info -Message "La propriété $Name n'a pas été modifiée."

        }

    }
    else{

        # On crée la propriété et on détruit la sortie
        New-ItemProperty -Path $Chemin -Name $Name -Value $Value -PropertyType String | Out-Null

        Write-CustomLog -Fichier $FichierLog -Type Info -Message  "Création de la propriété $Name avec la valeur $Value."

    }

    Write-CustomLog -Fichier $FichierLog -Type Info -Message  "Fin de la fonction Set-RegKey."

}

<#
    
    Créer une fonction qui s'appelle Write-CustomLog
    Elle veut loguer des messages dans des fichiers texte dans c:\Powershell\Log

    Elle prend en paramètre 2 arguments fichier et Message

    Par défaut le fichier utilisé est Default.log

    Elle doit écrire les messages dans le fichier spécifié sous la forme :

    10/09/2021 14:54:23 - C'est bientôt le weekend

    Où "C'est bientôt le weekend" est le message passé à la fonction

#>
function Write-CustomLog {
<#
.SYNOPSIS
    Cette fonction écrit des log.

.DESCRIPTION
    Cette fonction écrit des log dans des fichiers texte et peut ou non les afficher à la console.

.PARAMETER Fichier
    Est le nom du fichier log dans lequel écrire.

.PARAMETER Message
    Est le texte que l'on veut écrire dans le fichier.

.PARAMETER Type
    Peut être soit Error,Warning ou Info.

.PARAMETER Display
    S'il est passé, le message est affiché à la console.

.EXAMPLE
    Write-CustomLog -Message "Coucou"

    Ecrit Coucou dans Default.log.

.EXAMPLE
    Write-CustomLog -Message "Coucou" -Fichier Test.log.

    Ecrit Coucou dans test.log

.EXAMPLE
    Write-CustomLog -Message "Coucou" -Fichier Test.log -Type Error

    Ecrit Coucou dans test.log et type le message en erreur.

.EXAMPLE
    Write-CustomLog -Message "Coucou" -Fichier Test.log -Type Error -Display

    Ecrit Coucou dans test.log et type le message en erreur et l'affiche à la console.

#>
    Param(
        
        [String]
        $Fichier = "Default.log", # On met une valeur par défaut au paramètre

        [Parameter(Mandatory=$true)]
        [String]
        $Message,

        [ValidateSet("Error","Warning","Info")] # Les valeurs acceptées pour ce paramètre sont error,...
        [String]
        $Type = "Info",

        [Switch]
        $Display

    )

    # On crée et on formate la date
    $Maintenant = Get-Date -Format "dd/MM/yyyy HH:mm:ss"

    # On construit le message
    $MessageFinal = "$Maintenant - $Type - $Message"

    # On rajoute le contenu dans le fichier
    Add-Content -Path "C:\PowerShell\Logs\$Fichier" -Value $MessageFinal 

    # Si le paramètre Display a été passé
    if($Display){
        
        $Color = [PsCustomObject]@{
        
            "Error" = "Gray"
            "Warning" = "Yellow"
            "Info" = "White"
        
        }
        
        # On affiche le message
        Write-Host $Message -ForegroundColor $Color.$Type

    }

}

<#

    Créer une fonction Get-InfoCarte qui prend en paramètre l'IfIndex d'une carte réseau
    Cette fonction doit renvoyer un objet qui contient :
    - l'adresse IPv4 de la carte
    - le masque
    - la passerelle
    - les serveurs dns
    - le suffixe dns de la connexion

#>

function Get-InfoCarte{
    
    Param(
    
        [Parameter(Mandatory = $true)]
        [ValidateScript({$_ -in (Get-NetAdapter).ifIndex})]
        [Int]
        $IfIndex
    )

    $IpConf = Get-NetIPConfiguration -InterfaceIndex $IfIndex 
    $Masque = (Get-NetIPAddress -InterfaceIndex $IfIndex -AddressFamily IPv4).PrefixLength

    $ObjetRetour = [PsCustomObject]@{

        "Ipv4" = $IpConf.IPv4Address.IPAddress
        "Masque" = $Masque
        "Passerelle" = $IpConf.IPv4DefaultGateway.NextHop
        "Serveurs Dns" = $IpConf.DNSServer.ServerAddresses -join ","
        "Suffixe DNS" = $IpConf.NetProfile.Name 

    }

    $ObjetRetour

}
Function Get-JourJusquaAnniversaire{

    Param(
        
        [ValidateScript({$_ -gt (Get-Date)})]
        [DateTime]
        $Anniversaire

    )


    $Soustration = $Anniversaire - (Get-Date)

    Write-Host "Il reste $($Soustration.Days) jours jusqu'à ton anniversaire !"

}
function Get-Connectivity{

    Param(
        
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String[]]          # On définit le type du paramètre en tant que tableau de string
        $ComputerName,

        [Int[]]
        $Port,

        [Switch]
        $Csv

    )
    Begin{

        # On crée un tableau vide
        $CollRetour = @()

    }
    Process{

        foreach($Name in $ComputerName){

            $Ping = Test-Connection -ComputerName $Name -Count 2 -Quiet

            # Si le paramètre est une IP
            if($Name -match '^\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}$'){
        
                # On dit que l'ip c'est le nom
                $IP = $Name

                # On cherche le nom de l'ip
                $Nom = (Resolve-DnsName $IP -ErrorAction SilentlyContinue).NameHost
        
                # Si le nom n'existe pas
                if(-not $Nom){

                    $Nom = "Pas de résolution DNS"

                }

            }
            else{
 
                $Nom = $Name
                $IP = (Resolve-DnsName $Nom -Type A -ErrorAction SilentlyContinue).IpAddress

            }


            $ObjetRetour = [PsCustomObject]@{

                "Nom" = $Nom
                "IP" = $IP
                "Ping" = $Ping

            }

            # Si le paramètre Port a été passé
            if($Port){
            
                foreach($PortUnique in $Port){

                    $ResultPort = Test-NetConnection -ComputerName $IP -Port $PortUnique -InformationLevel Quiet -WarningAction SilentlyContinue

                    # On rajoute une propriété à l'objet retour
                    $ObjetRetour | Add-Member -Name "Port $PortUnique" -MemberType NoteProperty -Value $ResultPort

                }

            }
            $ObjetRetour

            # On rajoute l'objet dans la collection
            $CollRetour += $ObjetRetour

        }

    }
    End{

        # Si le paramètre csv est présent
        if($Csv){
            
            # On exporte la collection en csv
            $CollRetour | Export-Csv -Path C:\PowerShell\Connectivity.csv -Delimiter ";" -Encoding Default -NoTypeInformation

        }

    }

}
<#
    
    Faire une fonction qui prenne en paramètre le computername
    Sa valeur par défaut est Localhost
    Il peut prendre potentiellement plusieurs valeurs
    Il peut accepter des valeurs qui viennent du pipeline
    Cette fonction doit renvoyer un objet qui contient :
        - Modèle de machine
        - Modèle de proc
        - Ram Totale en Go
        - Ram Libre en Go
        - Domaine
        - Utilisateur connecté
        - Date d'install de l'OS
       
#>