   # Asks for credentals for office 365 tennant
$Credential = Get-Credential

   # Creates Exchange session
$ExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid" -Credential $credential -Authentication "Basic" -AllowRedirection
PS C:\WINDOWS\system32> Import-PSSession $ExchangeSession
   # Connects session
Import-PSSession $ExchangeSession

   # Code to add permissions
Add-MailboxFolderPermission -identity ConferenceRoom@kolakowski.us:\calendar -user matthew@kolakowski.us -accessrights reviewer

   # Checking if permissions correct
Get-MailboxFolderPermission ConferenceRoom@kolakowski.us:\calendar
