########################################
########################################
###    PowerShell
###    AD User Create (With homedrive and roaming profile.)
########################################
########################################

An easy, basic script that simply creates users in huge batches from a .csv file. Easy to use too, I hope.

###  How-to guide:

1. Start up powershell as admin.
2. Run script
3. Input what is asked for. 
 - With the DC questions it'll first ask for your domain and then the extension I.E: git and then local.
 - If you want the userdata to go to C:/Users you should specify it as such. Not as C:/Users/
4. Watch the miracles happen right before you. Not a single faith requirement in sight.

### CSV Help

Since the script only accepts certain formats here's the breakdown of what it accepts. (* Is required)

- GivenName* = First name of a user. Used as displayname. 
- Surname = Surname of a user.
- OtherName = Anything else in a user's name like "of"
- EmployeeID* = The ID of an employee. This is used as login name and actual AD name.
- EmailAddress = A user's email.
- Division = Where a user is.
- Date = The date at which a user joined the company. Will be entered in description box.

If for some bizzare reason the demand rises I could always impletent a password field. 



