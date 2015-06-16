
# Import CSV
Import-Csv "Users.csv" | ForEach-Object {Write-Host $_."Name"} {

# Set values
$LogonUsername = $_."LogonUsername" 
$Name = $_."Name"
$Displayname = $_."Displayname"

# Create Folder
New-Item -Path C:\Hey\$LogonUsername -Force -Type Directory  
New-Item -Path C:\Hey\$LogonUsername\UserData -Force -Type Directory 

# Create user and set stuff
New-ADUser `
-Name $Name `
-Path "OU=Scooliosis,DC=Scool,DC=Local" `
-SamAccountName $LogonUsername `
-Displayname $Displayname `
-AccountPassword (ConvertTo-SecureString "Welkom01" -AsPlainText -Force) `
-ChangePasswordAtLogon $true `
-Enabled $true `
-HomeDrive "H:" `
-HomeDirectory "\\WIN-6MS9H2UM9VJ\$Name\UserData" `
-ProfilePath: "\\WIN-6MS9H2UM9VJ\$Name\"
Add-ADGroupMember "Group1" "$LogonUsername"

# Share folder and set rights
New-SmbShare  -Name $Name -Path C:\Hey\$LogonUsername -ChangeAccess $LogonUsername

# Set NTFS
Icacls C:\Hey\$LogonUsername /inheritance:r /grant:r ${LogonUsername}:"(OI)(CI)M"

# Check if the user is there and write to log.
if( Get-ADUser -Filter "SAMAccountName -like $LogonUsername")
{write-host "Created $Name" 
  Out-File -FilePath C:\Hey\Log.txt -inputobject "Created $Name" -append}
  else {write-host "Failed to create $Name"}

} | Out-Null
