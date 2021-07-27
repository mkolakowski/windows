<#
#>

#Import Modules
Import-Module ActiveDirectory 

#Start-Variaibles
    $PathToImportCSV    = “C:\Temp\Users-To-Add.csv”
    $CSV_Path           = "C:\Logs\Employees.csv"
    $CSV_Group_Headers  = '"Group01","Group02","Group03"'
    $CSV_Input          = @(
                            '"FirstName","LastName","Department","State","EmployeeID","Office","UserPrincipalName","SamAccountName","Password","Enabled"'
                            '"Joe","Jones","Sales","Ohio","1234","Primary","[Joe.Jones@domain.local](<mailto:Joe.Jones@domain.local>)","Joe.Jones","P!55word","True'
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
    Modified version of source on https://adamtheautomator.com/import-csv-foreach/
.ORGINAL
.SYNOPSIS
    Pulls list of users from CSV and adds them to group
.EXAMPLE
    Bulk_Add_Users
#>
function Bulk_Add_Users {
    Import-Csv $PathToImportCSV | ForEach-Object {
        New-ADUser `
            -Name $($_.FirstName + " " + $_.LastName) `
            -GivenName $_.FirstName `
            -Surname $_.LastName `
            -Department $_.Department `
            -State $_.State `
            -EmployeeID $_.EmployeeID `
            -DisplayName $($_.FirstName + " " + $_.LastName) `
            -Office $_.Office `
            -UserPrincipalName $_.UserPrincipalName `
            -SamAccountName $_.SamAccountName `
            -AccountPassword $(ConvertTo-SecureString $_.Password -AsPlainText -Force) `
            -Enabled $True
    }
}


