<#
#>

#Application paremeters
    param (
        [string] $PathToImportCSV,
        [string] $mode # Can be set to single or multi
        )


#Import Modules
Import-Module ActiveDirectory 

#Start-Variaibles
    if (!$PathToImportCSV) { $PathToImportCSV = “C:\Temp\Users-To-Add.csv” }


    $GroupToAddUsers    = “Group-Name”
    $CSVColumnUsers     = ’User-Name’
    $CSV_Path           = "C:\Logs\Sample.csv"
    $CSV_Group_Headers  = '"Group01",'
    $CSV_Input          = @(
                            '"Adam",'
                            '"Joe",'
                            '"Mary",'
                            )
#End-Variables

<#
.Source
    Modified version of https://mcpmag.com/articles/2017/06/08/creating-csv-files-with-powershell.aspx
.SYNOPSIS
    Generates sample CSV file for import
.EXAMPLE
    Generate_Sample_CSV
#>
function Generate_Sample_CSV_Users {
        #Variable Generation

    Add-Content -Path $CSV_Path -Value $CSV_Group_Headers
    $CSV_Input | ForEach-Object { Add-Content -Path  $CSV_Path -Value $_ }
}
<#
.Source
    Modified version of source on https://www.petenetlive.com/KB/Article/0001475
.ORGINAL
    Import-Csv -Path “C:\Temp\Users-To-Add.csv” | ForEach-Object {Add-ADGroupMember -Identity “Group-Name” -Members $_.’User-Name’}
.SYNOPSIS
    Pulls list of users from CSV and adds them to group
.EXAMPLE
    Bulk_Add_Users
#>
function Bulk_Add_Users {
    Import-Csv -Path $PathToImportCSV | ForEach-Object 
    {
        Add-ADGroupMember -Identity $GroupToAddUsers -Members $_.$CSVColumnUsers
    }
}
<#
.SYNOPSIS
    Pulls data from each CSV file in the $PathToImportCSV folder and 
    used the first cell as the group name then adds each user to the group
.EXAMPLE
    Bulk_Add_Users
#>
function Bulk_Add_Multi_Groups {

    #looks at folder
    Get-ChildItem –Path $PathToImportCSV | Foreach-Object 
    {
        Import-Csv -Path $_.FullName | ForEach-Object 
        {
            Add-ADGroupMember -Identity $GroupToAddUsers -Members $_.$CSVColumnUsers
        }
    }

}




Generate_Sample_CSV
Bulk_Add_Users
Bulk_Add_Multi_Groups
