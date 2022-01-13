
function New-IgLoremIpsum {
    <#
    .Synopsis
        Creates Lorem Ipsum paragraphs.
    .Description
        User inputs how many paragraphs or words they need they need, defaults to 5 paragraphs.
        Then, foreach paragraph generates a number of sentences between 4 and 10.
        And foreach sentence, generates a number of words that are 4 to 10 characters long.
        Then foreach word, randomly generates the letters.
        The first letter of the sentences are capitalized and the very first words are "Lorem Ipsum"
        You cannot request more than 100 paragraphs or 5000 words. This won't be an exact number
        due to the randomness of the script, but it'll be sorta close.
    .Example
        New-IgLoremIpsum
        This will generate 5 paragraphs of Lorem Ipsum.
    .Example
        New-IgLoremIpsum -Paragraphs 10
        This will generate 10 paragraphs of Lorem Ipsum.
    .Inputs
        None required, but an integer of how many paragraphs or words to generate.
    .Outputs
        string
    .Notes
        Created by donn@thehouseofdonn.com
        Created on 2016-12-07
    .Link
        http://www.powershellusers.com
    .Link
        http://donnigway.wordpress.com
    #>
    [CmdletBinding(DefaultParameterSetName = 'DefParamSet',
                   SupportsShouldProcess = $true,
                   PositionalBinding = $false,
                   ConfirmImpact = 'Medium')]
    [OutputType([String])]
    Param (
        # This is a number of how many paragraphs you want to create. Max is 100 paragraphs.
        [Parameter(Mandatory = $false,
                   ParameterSetName = 'DefParamSet')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1, 100)]
        [int]$Paragraphs = 5,
        
        # This is how words to generate. Based on how many words, the script will figure out how many paragraphs are needed. The maximum number of words to tell the script is 5000.
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'ParamSet2')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(3, 5000)]
        [int]$Count,
        
        # This will NOT send any output to the screen, but send the output directly to the clipboard.
        # Useful if you want to put the output into another medium.
        [switch]$SendToClipBoard
    )
    Begin {
        Function Get-IgCurrentLineNumber {
            # Simply Displays the Line number within the script.
            [string]$line = $MyInvocation.ScriptLineNumber
            $line.PadLeft(4, '0')
        }
        
        # List of letters I wanted to get randomness from.
        # Yes there are better ways, but to show examples and simplify...
        $list = @('a', 'a', 'b', 'c', 'd', 'e', 'e', 'f', 'g', 'h', 'i', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'o', 'p', 'q', 'r', 's', 't', 'u', 'u', 'v', 'w', 'x', 'y', 'z')
        
        if ($PSBoundParameters.ContainsKey('Count')) {
            [int]$Paragraphs = [int](($Count + 200)/80)
            Write-Verbose "[Line: $(Get-IgCurrentLineNumber)] Paragraphs from Count: $Paragraphs"
        }
    }
    Process {
        [string]$allLoremIpsum = @()
        $totalWords = 0
        $FirstParagraph = $true
        
        #region Looping thru each Paragraph.
        for ($p = 1; $p -lt ($Paragraphs + 1); $p++) {
            Write-Verbose "[Line: $(Get-IgCurrentLineNumber)] Paragraph '$p'"
            [string]$currentParagraph = @()
            
            #region Figure out the number of sentences
            $sentencesInParagraph = Get-Random -Minimum 4 -Maximum 18
            for ($s = 1; $s -lt ($sentencesInParagraph + 1); $s++) {
                Write-Verbose "[Line: $(Get-IgCurrentLineNumber)]   Sentence '$s'"
                [string]$currentSentence = @()
                
                #region Figure out how many words are in the sentence
                $wordsInSentence = Get-Random -Minimum 4 -Maximum 18
                #[int]$WordCountInSentence = 0
                for ($w = 1; $w -lt ($wordsInSentence + 1); $w++) {
                    
                    Write-Verbose "[Line: $(Get-IgCurrentLineNumber)]     Word '$w'"
                    [string]$currentWord = @()
                    
                    #region Adding Letters to words
                    if ($p -eq 1 -and $s -eq 1 -and $w -eq 1) {
                        # Write-Verbose "[Line: $(Get-IgCurrentLineNumber)]     Lorem Ipsum"
                        $currentWord += "Lorem Ipsum"
                        $totalWords += 2
                    } else {
                        for ($l = 1; $l -lt ((Get-Random -Minimum 4 -Maximum 10) + 1); $l++) {
                            if ($w -eq 1 -and $l -eq 1) {
                                $currentLetter = ($list | Get-Random).ToUpper()
                                # Write-Verbose "[Line: $(Get-IgCurrentLineNumber)]       Letter '$l' '$currentLetter'"
                            } else {
                                $currentLetter = $list | Get-Random
                                # Write-Verbose "[Line: $(Get-IgCurrentLineNumber)]       Letter '$l' '$currentLetter'"
                            }
                            $currentWord += $currentLetter
                        }
                        $totalWords++
                        
                    } # ending adding letters to words
                    #endregion
                    
                    if ($currentWord -ne 'Lorem Ipsum') {
                        $currentWord = ($currentWord -replace '[^\w]', '')
                    }
                    
                    if ($PSBoundParameters.ContainsKey('Count')) {
                        if ($totalWords -eq $Count) {
                            Write-Verbose -Message "[Line: $(Get-IgCurrentLineNumber)] I want to stop. Now!"
                            $currentWord = " $currentWord."
                            
                            # Chaning Values to something bigger than the loops
                            $w = $wordsInSentence + $w
                            $s = $sentencesInParagraph + $s
                            $p = $Paragraphs + $p
                        } else {
                            if ($w -eq $wordsInSentence) {
                                # Write-Verbose "[Line: $(Get-IgCurrentLineNumber)] Period"
                                $currentWord = " $currentWord."
                            } else {
                                # Write-Verbose "[Line: $(Get-IgCurrentLineNumber)] Space"
                                if ($w -eq 1 -and $s -eq 1) {
                                    $currentWord = "$currentWord"
                                } else {
                                    $currentWord = " $currentWord"
                                }
                            }
                        }
                    } else {
                        if ($w -eq $wordsInSentence) {
                            # Write-Verbose "[Line: $(Get-IgCurrentLineNumber)] Period"
                            $currentWord = " $currentWord."
                        } else {
                            # Write-Verbose "[Line: $(Get-IgCurrentLineNumber)] Space"
                            if ($w -eq 1 -and $s -eq 1) {
                                $currentWord = "$currentWord"
                            } else {
                                $currentWord = " $currentWord"
                            }
                        }
                    }
                    
                    Write-Debug -Message "Ending Word"
                    
                    # Write-Verbose "[Line: $(Get-IgCurrentLineNumber)]     Current Word: '$currentWord'"
                    $currentSentence += $currentWord
                    
                } # ending words
                #endregion
                
                Write-Verbose "[Line: $(Get-IgCurrentLineNumber)]   Current Sentence: $currentSentence"
                Write-Verbose "[Line: $(Get-IgCurrentLineNumber)]   Current Words In Sentence: $wordsInSentence"
                
                Write-Verbose "[Line: $(Get-IgCurrentLineNumber)]   Total Words: $totalWords"
                $currentParagraph += $currentSentence
                Write-Debug -Message "Ending Sentence"
            } # ending Sentences
            #endregion
            
            if ($FirstParagraph) {
                Write-Verbose "[Line: $(Get-IgCurrentLineNumber)] First PP"
                $allLoremIpsum = @"
$currentParagraph
"@
                $FirstParagraph = $false
            } else {
                Write-Verbose "[Line: $(Get-IgCurrentLineNumber)] Not first PP"
                $allLoremIpsum += @"
$currentParagraph
"@
                Write-Debug -Message "Ending Paragraph"
            }
        } # ending paragraph
        #endregion
        
    }
    End {
        Write-Verbose "[Line: $(Get-IgCurrentLineNumber)] Output Total Words: $totalWords"
        if ($SendToClipBoard) {
            $allLoremIpsum | Set-Clipboard
        } else {
            $allLoremIpsum
        }
    }
}
<#
    Ce script veut contruire une arborescence dans c:\Powershell\Rapports

    Un dossier par année

    Un dossier par mois

    Un dossier sera créé par semaine de l'annéé 
        
    Un nombre aléatoire de fichiers 

    Qui contiennent un nombre aléatoire de lignes qui doivent commencer par le nom du dossier du site


#>

# On définit le chemin où l'on travaille
$Chemin = "c:\Powershell\Rapports"

# On supprime tout ce qu'on va créer après
Remove-Item -Path $Chemin -Recurse -Force

# On définit les sites qui vont être créés
$ListeSite = "Site 1", "Site 2", "Site 3"

# Pour chaque site dans la liste des sites
foreach($Site in $ListeSite){

    # On crée le dossier site
    $ObjetSite = New-Item -Path $Chemin -Name $Site -ItemType Directory 

    # De 2019 à 2021
    for($Annee = 2019 ; $Annee -le 2021 ; $Annee++){

        # On crée le dossier de l'année 
        $ObjetAnnee = New-Item -Path $ObjetSite.FullName -Name $Annee -ItemType Directory

        # On crée une date au premier janvier de l'année en cours
        $DateEnCours = Get-Date -Day 1 -Month 1 -Year $Annee

        # Tant que l'année de la date est la bonne année
        while($DateEnCours.Year -eq $Annee){

            # On récupère le mois de la date
            $Mois = "$($DateEnCours.Month)$(Get-Date $DateEnCours -Format 'MMMM')"

            # On construit le chemin du dossier mois
            $CheminMois = Join-Path $ObjetAnnee.FullName $Mois

            # Si le dossier du mois n'existe pas 
            if(-not (Test-Path $CheminMois)){

                # On crée le dossier
                $ObjetMois = New-Item -Path $CheminMois -ItemType Directory

            }

            # Si la date est un lundi
            if($DateEnCours.DayOfWeek.value__ -eq 1){
                
                # On crée le nom du dossier du lundi
                $DossierLundi = Get-Date $DateEnCours -Format "yyyy-MM-dd"

                # On contruit le chemin
                $CheminSemaine = Join-Path $CheminMois $DossierLundi

                # On crée le dossier de la semaine
                $ObjetSemaine = New-Item -Path $CheminSemaine -ItemType Directory
            
                # On crée un nombre entre 2 et 10 de fichiers
                $NbFichiers = Get-Random -Minimum 2 -Maximum 10

                # Pour chaque nombre
                1..$NbFichiers | %{

                    # On génère un nombre aléatoire de paragraphes entre 1 et 5
                    $Contenu = $Site + (New-IgLoremIpsum -Paragraphs (Get-Random -Minimum 1 -Maximum 5))

                    # On crée le fichier
                    $ObjFichier = New-Item -Path $CheminSemaine -Name "Fichier_$($Site)_$_.txt"

                    # On ajoute le contenu
                    Add-Content -Value $Contenu -Path $ObjFichier.FullName

                }

            }

            # On ajoute un jour à la date
            $DateEnCours = $DateEnCours.AddDays(1)

        }

    }

}


