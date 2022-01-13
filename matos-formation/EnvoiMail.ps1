<#
    Les blocs de textes sont des string qui peuvent contenir des retours à la ligne :

    Syntaxe : 

    @'
        Je suis du texte
        avec des retours à la ligne
    '@



#>

$Bloc = @'
<h1>Annonce Importante !</h1>
<p>
Monsieur,
</p>
<p>
Je vous écris pour vous dire que je vous déteste car vous êtes un odieux <strong>CONNARD</strong> !!!
<br />
Sincèrement,
</p>
<img width='300px' src='https://cdn.webshopapp.com/shops/103628/files/334323306/sex-fuck-you-fuck.jpg' alt='Connard' />
<p>
<strong>
Nicolas Bernard
</strong>
</p>
'@


$password = ConvertTo-SecureString "Arkesys1!" -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential ("user1@groupe-arkesys.com", $password)



Send-MailMessage `    -To "nbernard@azer-it.fr", "romain@backofficelyon.fr", "valverde.thomas@outlook.fr" `    -From "user1@groupe-arkesys.com" `    -Subject "Mon Super Mail Powershell" `    -BodyAsHtml $Bloc `    -SmtpServer "ssl0.ovh.net" `    -Port 587 `    -UseSsl `    -Credential $Cred `    -Encoding UTF8






