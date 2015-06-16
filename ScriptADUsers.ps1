
# Importen van CSV 
Import-Csv "Users.csv" | ForEach-Object {

# $ Vallues aangeven
$LogonUsername = $_."LogonUsername" 
$Name = $_."Name"
$Displayname = $_."Displayname"

# Map Aanmaken. Vreemde naam, fixen misschien?
New-Item -Path C:\Shares\$LogonUsername -Force -Type Directory  
New-Item -Path C:\Shares\$LogonUsername\UserData -Force -Type Directory 

# Gebruiker aanmaken en dingen goed zetten
New-ADUser `
-Name $Name `
-Path "OU=Scooliosis,DC=Scool,DC=Local" `
-SamAccountName "$LogonUsername" `
-Displayname $Displayname `
-AccountPassword (ConvertTo-SecureString "Welkom01" -AsPlainText -Force) `
-ChangePasswordAtLogon $true `
-Enabled $true `
-HomeDrive "H:" `
-HomeDirectory "\\WIN-6MS9H2UM9VJ\$Name\UserData" `
-ProfilePath: "\\WIN-6MS9H2UM9VJ\$Name\"
Add-ADGroupMember "Group1" "$LogonUsername"

# Map Sharen en rechten geven aan gebruiker
New-SmbShare  -Name $Name -Path C:\Shares\$LogonUsername -ChangeAccess $LogonUsername

# NTS Goed zetten
Icacls C:\Shares\$LogonUsername /inheritance:r /grant:r ${LogonUsername}:"(OI)(CI)M"

}  
