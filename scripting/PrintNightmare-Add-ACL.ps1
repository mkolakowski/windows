<#
.SYNOPSIS
Creates or removes ACL to block SYSTEM access to print spooler directory in response to CVE 2021 34527.

.DESCRIPTION
Creates or removes ACL to block SYSTEM access to print spooler directory in response to CVE 2021 34527.

.NOTES
Source of script: https://blog.truesec.com/2021/06/30/fix-for-printnightmare-cve-2021-1675-exploit-to-keep-your-print-servers-running-while-a-patch-is-not-available/ 
Created by Matthew Kolakowski at Intrust IT on 7/6/2021. https://www.intrust-it.com/
Complete testing on all operating systems has NOT been done on this script yet, so run this at your own risk and further research it.

#>
$date              = (get-date).toString("yyyy-MM-dd hh-mm-ss tt")
$Logpath           = "C:\InTrust\Logs"
$LogFileOldACL     = $Logpath + '\' + $date + ' - OldACL.txt'
$LogFileNewACL     = $Logpath + '\' + $date + ' - NewACL.txt'
$LogFileCurrentACL = $Logpath + '\' + $date + ' - CurrentACL.txt'

if (!$Logpath) {
    mkdir $Logpath 
}

$Path = "C:\Windows\System32\spool\drivers"
$Acl = (Get-Item $Path).GetAccessControl('Access')
if ($Logpath) {
    $Acl | Select-object * |  Out-File $LogFileOldACL 
}
$Ar = New-Object  System.Security.AccessControl.FileSystemAccessRule("System", "Modify", "ContainerInherit, ObjectInherit", "None", "Deny")
$Acl.AddAccessRule($Ar) | Out-Null
Set-Acl $Path $Acl

#Verify
$FixACL = Get-Acl "C:\Windows\System32\spool\drivers"
if ($Logpath) {
    $FixACL | Select-object * |  Out-File $LogFileNewACL
}
