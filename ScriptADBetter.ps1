﻿# Requires User Input
$CSV = Read-Host 'Please specify the path of your .csv'
$COMP = Read-Host 'Please specify your computer name'
$OU = Read-Host 'Please specify an OU'
$DC1 = Read-Host 'Please specify a DC' 
$DC2 = Read-Host 'Please specify a DC extension'

# Import CSV
Import-Csv $CSV | ForEach-Object {Write-Host $_."Name"} {

# Import Variables
 
$GivenName = $_. "GivenName"
$OtherName = $_. "OtherName"
$Surname = $_. "Surname"
$Name = $_. "$GivenName.$Surname"
$Displayname = $Name
$LogonUsername = $_. $Name
$EmailAddress = $_. "EmailAddress"
$EmployeeID = $_. "EmployeeID"
$Division = $_. "Division"
$EnrollmentDate = $_. "Date"

# Create Folder
New-Item -Path C:\Hey\$LogonUsername -Force -Type Directory  
New-Item -Path C:\Hey\$LogonUsername\UserData -Force -Type Directory 

# Create user and set stuff
New-ADUser `
-Name $Name `
-Path "OU=$OU,DC=$DC1,DC=$DC2" `
-SamAccountName $LogonUsername `
-Displayname $Displayname `
-AccountPassword (ConvertTo-SecureString "Welkom01" -AsPlainText -Force) `
-ChangePasswordAtLogon $true `
-Enabled $true `
-GivenName $GivenName `
-EmailAddress $EmailAddress `
-EmployeeID = $EmployeeID `
-Divison = $Division `
-Description = $EnrollmentDate
-OtherName $OtherName `
-Surname $Surname `
-HomeDrive "H:" `
-HomeDirectory "\\2016test1\$Name\UserData" `
-ProfilePath: "\\2016test1\$Name\"
# Add-ADGroupMember "Group1" "$LogonUsername"

# Share folder and set rights
New-SmbShare  -Name "$Name" -Path C:\Hey\$LogonUsername -ChangeAccess $LogonUsername

# Set NTFS
Icacls C:\Hey\$LogonUsername /inheritance:r /grant:r ${LogonUsername}:"(OI)(CI)M"

# Check if the user is there and write to log.
if( Get-ADUser -f "SamAccountName -like '$LogonUsername'")
{write-host "Created $Name"
  Out-File -FilePath C:\Hey\Log.txt -inputobject "Created $Name" -append}
  else {write-host "Failed to create $Name"}

} | Out-Null
