<#

Writen by : JPLW

Version : 0.1 POC (NOT TO BE USED IN PROD)

#>

Add-Type -AssemblyName System.Windows.Forms

$MainForm = New-Object System.Windows.Forms.Form
$ErrorForm = New-Object System.Windows.Forms.Form

# Define sizes of the labels and text boxes 
$textboxSize = New-Object System.Drawing.Size(140,20)
$labelSize = New-Object System.Drawing.Size(168,20)

$MainForm.Size = '480,300'
$MainForm.Text = "POC - PassExpire GUI"
$MainForm.BackColor = "#9FADEA"
$MainForm.MaximizeBox = $false

$ErrorForm.Size = '275,175'
$ErrorForm.Text = "Error"
$ErrorForm.BackColor = "#9FADEA"
$ErrorForm.MaximizeBox = $false

$Error_Title = New-Object system.Windows.Forms.Label
$Error_Title.text = "Error - Unable to find User"
$Error_Title.AutoSize = $true
$Error_Title.location = New-Object System.Drawing.Point(20,50)
$Error_Title.Font = 'Microsoft Sans Serif,13'

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

$label_DisplayName = New-Object System.Windows.Forms.Label
$label_DisplayName.Location = New-Object System.Drawing.Size(10,150)
$label_DisplayName.Size = $labelSize
$label_DisplayName.TextAlign = "MiddleCenter"
$label_DisplayName.Text = "Display Name"
     
$textbox_DisplayName = New-Object System.Windows.Forms.TextBox
$textbox_DisplayName.Location = New-Object System.Drawing.Size(21,175)
$textbox_DisplayName.Size = $textboxSize
$textbox_DisplayName.ReadOnly = $true

$Button_Search = New-Object System.Windows.Forms.button
    $Button_Search.Size = New-Object System.Drawing.Size(75,23)
    $Button_Search.Location = New-Object System.Drawing.Size(330,220)
    $Button_Search.TextAlign = "MiddleCenter"
    $Button_Search.Text = "Search"
    $Button_Search.BackColor = "74, 225, 88"
    $button_Click = {try {
        $Username = $Textbox_Username.Text
        $Details = Get-Aduser $Username -properties DisplayName,msDS-UserPasswordExpiryTimeComputed
        $textbox_DisplayName.text = $Details.DisplayName
        $ExpireDate = [datetime]::FromFileTime($Details."msDS-UserPasswordExpiryTimeComputed")
        $Textbox_ExpireDate.text = $ExpireDate
        }
    catch {
        $ErrorForm.controls.AddRange(@($Error_Title))
        [void]$ErrorForm.ShowDialog()
        }}
    $Button_Search.add_click($button_Click)
$MainForm.controls.AddRange(@($Titel,$Description,$Label_Username,$Textbox_Username,$textbox_DisplayName,$label_DisplayName,$Label_ExpireDate,$Textbox_ExpireDate,$Button_Search))
[void]$MainForm.ShowDialog()