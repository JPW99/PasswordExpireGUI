<#

Writen by : JPLW

Version : 0.1 POC (NOT TO BE USED IN PROD)

#>

Add-Type -AssemblyName System.Windows.Forms

$MainForm = New-Object System.Windows.Forms.Form

# Define sizes of the labels and text boxes 
$textboxSize = New-Object System.Drawing.Size(140,20)
$labelSize = New-Object System.Drawing.Size(168,20)

$MainForm.Size = '480,300'
$MainForm.Text = "POC - PassExpire GUI"
$MainForm.BackColor = "#ffffff"

$Titel = New-Object system.Windows.Forms.Label
$Titel.text = "POC - PassExpire GUI"
$Titel.AutoSize = $true
$Titel.location = New-Object System.Drawing.Point(20,20)
$Titel.Font = 'Microsoft Sans Serif,13'

$Description = New-Object system.Windows.Forms.Label
$Description.text = "Find password expiry date for selected user. Please search via username from AD"
$Description.AutoSize = $false
$Description.width = 450
$Description.height = 50
$Description.location = New-Object System.Drawing.Point(20,50)
$Description.Font = 'Microsoft Sans Serif,10'

$Label_Username = New-Object System.Windows.Forms.Label
$Label_Username.Location = New-Object System.Drawing.Size(10,100)
$Label_Username.Size = $labelSize
$Label_Username.TextAlign = "MiddleCenter"
$Label_Username.Text = "Username"

$Textbox_Username = New-Object System.Windows.Forms.TextBox
$Textbox_Username.Location = New-Object System.Drawing.Size(21,125)
$Textbox_Username.Size = $textboxSize

$Label_ExpireDate = New-Object System.Windows.Forms.Label
$Label_ExpireDate.Location = New-Object System.Drawing.Size(155,100)
$Label_ExpireDate.Size = $labelSize
$Label_ExpireDate.TextAlign = "MiddleCenter"
$Label_ExpireDate.Text = "Date of password expire"
 
$Textbox_ExpireDate = New-Object System.Windows.Forms.TextBox
$Textbox_ExpireDate.Location = New-Object System.Drawing.Size(170,125)
$Textbox_ExpireDate.Size = $textboxSize
$Textbox_ExpireDate.ReadOnly = $true

$label_Email = New-Object System.Windows.Forms.Label
$label_Email.Location = New-Object System.Drawing.Size(10,150)
$label_Email.Size = $labelSize
$label_Email.TextAlign = "MiddleCenter"
$label_Email.Text = "Email"
     
$textbox_Email = New-Object System.Windows.Forms.TextBox
$textbox_Email.Location = New-Object System.Drawing.Size(21,175)
$textbox_Email.Size = $textboxSize
$textbox_Email.ReadOnly = $true

$Button_Search = New-Object System.Windows.Forms.button
    $Button_Search.Size = New-Object System.Drawing.Size(75,23)
    $Button_Search.Location = New-Object System.Drawing.Size(330,220)
    $Button_Search.TextAlign = "MiddleCenter"
    $Button_Search.Text = "Search"
    $Button_Search.BackColor = "74, 225, 88"
    $Button_Search.Add_Click<#({

        try {
           $Details = Get-Aduser $Textbox_Username.text -properties DisplayName,msDS-UserPasswordExpiryTimeComputed,EmailAddress
           $Details.DisplayName
           $Details.msDS-UserPasswordExpiryTimeComputed
           $Details.EmailAddress

           $textbox_Email.Text = $Details.EmailAddress
           $Textbox_ExpireDate.Text = [datetime]::FromFileTime($Details.msDS-UserPasswordExpiryTimeComputed)
                    }
        catch {
            #Fails to find user message
        }

    })
    #>
$MainForm.controls.AddRange(@($Titel,$Description,$Label_Username,$Textbox_Username,$textbox_Email,$label_Email,$Label_ExpireDate,$Textbox_ExpireDate,$Button_Search))
[void]$MainForm.ShowDialog()