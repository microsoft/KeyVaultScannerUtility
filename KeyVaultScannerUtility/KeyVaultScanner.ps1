Get-ChildItem $PSScriptRoot -Recurse | Unblock-File
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form1 = New-Object System.Windows.Forms.Form
$form1.Text = 'KeyVault Scanner'
$form1.Size = New-Object System.Drawing.Size(300,570)
$form1.StartPosition = 'CenterScreen'


$loginButton = New-Object System.Windows.Forms.Button
$loginButton.Location = New-Object System.Drawing.Point(40,220)
$loginButton.Size = New-Object System.Drawing.Size(100,23)
$loginButton.Text = 'Login To Azure'
$loginButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form1.AcceptButton = $loginButton
$form1.Controls.Add($loginButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(140,220)
$cancelButton.Size = New-Object System.Drawing.Size(100,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form1.CancelButton = $cancelButton
$form1.Controls.Add($cancelButton)

$form1.Topmost = $true
#$form.Add_Shown({$textBox.Select()})
$result = $form1.ShowDialog()


if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
  $x = Connect-AzAccount 
  
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'KeyVault Scanner'
$form.Size = New-Object System.Drawing.Size(620,400)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,220)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'Search'
$okButton.UseVisualStyleBackColor = $true
$okButton.Add_Click({ButtonGo_Click})

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,220)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter the Subscription ID:'
$form.Controls.Add($label)

#$textBox1 = New-Object System.Windows.Forms.TextBox
#$textBox1.Location = New-Object System.Drawing.Point(10,40)
#$textBox1.Size = New-Object System.Drawing.Size(260,20)
#$form.Controls.Add($textBox1)
$DropDown = New-Object System.Windows.Forms.ComboBox
$DropDown.Location = New-Object System.Drawing.Point(10,40)
$DropDown.Size = New-Object System.Drawing.Size(260,20)
$subscriptions = Get-AzSubscription

foreach($sub in $subscriptions)
{
[void]$DropDown.Items.Add($sub.Name)
}
$Form.Controls.Add($DropDown)   
function select_Sub
{
$Subscription= $DropDown.Text

$sub = Select-AzSubscription -Subscription $DropDown.Text
$KeyVaults = Get-AzKeyVault
$DropDown2.Items.Clear()
foreach($Kv in $KeyVaults)
{
[void]$DropDown2.Items.Add($Kv.VaultName)
}
}
$DropDown.Add_SelectedIndexChanged({select_Sub})    

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,70)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter Secret or Key that you want to search'
$form.Controls.Add($label)

$DropDown1 = New-Object System.Windows.Forms.ComboBox
$DropDown1.Location = New-Object System.Drawing.Point(10,90)
$DropDown1.Size = New-Object System.Drawing.Size(260,40)

[void] $DropDown1.Items.Add('Secret')
[void] $DropDown1.Items.Add('Key')

$hash = @{}
$keys = New-Object -TypeName "System.Collections.ArrayList"

function get_selectedvalue
{
$SecretorKey = $DropDown1.SelectedItem 

}

$Form.Controls.Add($DropDown1)      
#$DropDown1.Add_SelectedIndexChanged({get_selectedvalue})  
   


$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,120)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter the value that you want to search'
$form.Controls.Add($label)

$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Location = New-Object System.Drawing.Point(10,140)
$textBox3.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox3)



$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,170)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter the KeyVault Name'
$form.Controls.Add($label)

#$textBox4 = New-Object System.Windows.Forms.TextBox
#$textBox4.Location = New-Object System.Drawing.Point(10,190)
#$textBox4.Size = New-Object System.Drawing.Size(260,20)
#$form.Controls.Add($textBox4)

$DropDown2 = New-Object System.Windows.Forms.ComboBox
$DropDown2.Location = New-Object System.Drawing.Point(10,190)
$DropDown2.Size = New-Object System.Drawing.Size(260,20)
$Form.Controls.Add($DropDown2)  

$progressBar1 = New-Object System.Windows.Forms.ProgressBar
$progressBar1.Name = 'progressBar1'
$progressBar1.Value = 0
$progressBar1.Style="Continuous"

$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 560
$System_Drawing_Size.Height = 20
$progressBar1.Size = $System_Drawing_Size

$progressBar1.Left = 10
$progressBar1.Top = 300

$form.Controls.Add($progressBar1)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(310,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Result'
$form.Controls.Add($label)

$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(310,0)
$label4.Size = New-Object System.Drawing.Size(280,20)
$label4.Text = 'Logged in as: '+$x.Context.Account.Id
$form.Controls.Add($label4)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,250)
$label1.Size = New-Object System.Drawing.Size(280,40)
$form.Controls.Add($label1)

#$textBox5 = New-Object System.Windows.Forms.TextBox
#$textBox5.Location = New-Object System.Drawing.Point(10,320)
#$textBox5.Multiline = $true
#$textBox5.Scrollbars = "Vertical"
#$textBox5.Size = New-Object System.Drawing.Size(260,200)
#$form.Controls.Add($textBox5)
  
$listBox = New-Object System.Windows.Forms.Listbox
$listBox.Location = New-Object System.Drawing.Point(310,40)
$listBox.Size = New-Object System.Drawing.Size(260,130)
$listBox.HorizontalScrollbar = $true
$listBox.SelectionMode = 'MultiExtended'

$form.Controls.Add($listBox)
$form.Topmost = $true

$label11 = New-Object System.Windows.Forms.Label
$label11.Location = New-Object System.Drawing.Point(310,170)
$label11.Size = New-Object System.Drawing.Size(280,20)
$label11.Text = 'Please enter the value that you want to replace'
$label11.Visible = $true
$form.Controls.Add($label11)

$textBox5 = New-Object System.Windows.Forms.TextBox
$textBox5.Location = New-Object System.Drawing.Point(310,190)
$textBox5.Size = New-Object System.Drawing.Size(260,20)
$textBox5.Enabled = $false
$form.Controls.Add($textBox5)

$exportButton = New-Object System.Windows.Forms.Button
$exportButton.Location = New-Object System.Drawing.Point(350,220)
$exportButton.Size = New-Object System.Drawing.Size(100,23)
$exportButton.Text = 'Export to CSV'
$exportButton.UseVisualStyleBackColor = $true
$exportButton.Add_Click({Export_Excel})
$exportButton.Enabled = $false


$updateButton = New-Object System.Windows.Forms.Button
$updateButton.Location = New-Object System.Drawing.Point(450,220)
$updateButton.Size = New-Object System.Drawing.Size(75,23)
$updateButton.Text = 'Update'
$updateButton.UseVisualStyleBackColor = $true
$updateButton.Add_Click({updatesecret})
$updateButton.Enabled = $false

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(310,250)
$label2.Size = New-Object System.Drawing.Size(280,40)
$form.Controls.Add($label2)

$form.Controls.Add($updateButton)
Function Export_Excel
{
try{
$myDesktop = [Environment]::GetFolderPath("Desktop")
&{$hash.getenumerator() |
  foreach {new-object psobject -Property @{Key = $_.name;Secret=$_.value}}
 } | export-csv $myDesktop/scanresult.csv -notype
 $label2.Text = "File saved to $myDesktop/scanresult.csv"

 }
 catch
{$label2.Text = Write-Output "An error occurred:"
 $label2.Text = Write-Output $_

 }
}

$form.Controls.Add($exportButton)

Function ButtonGo_Click
{
   
    $SecretorKey = $DropDown1.SelectedItem
    $value= $textBox3.Text
    $KeyVault= $DropDown2.Text
    $Subscription= $DropDown.Text
    $secretvalue = $listBox 
    #$textBox5.Text = ''
    $hash.Clear()
    $listBox.Items.Clear()
    $keys.Clear()
    $label2.Text = " "
    $progressbar1.Value = 0
    $textBox5.Enabled = $false
    $textBox5.Text = ' '
    $exportButton.Enabled = $false
    $updateButton.Enabled = $false
    $form.Refresh()
    
try
{
$label1.Text =  Write-Output "Searching..."$SecretorKey $value "in KeyVault" $KeyVault "in sub " $Subscription
$sub = Select-AzSubscription -Subscription $Subscription

$secretCount = Get-AzKeyVaultSecret -VaultName $KeyVault | measure

$count = $secretCount.Count
$form.Refresh()
$secretNames = Get-AzKeyVaultSecret -VaultName $KeyVault

$counter = 1
Foreach ($secretName in $secretNames)
{
$label1.Text = Write-Output "Searching...($counter/ $count)"
[int]$pct = ($counter/$secretCount.Count)*100
#update the progress bar
$progressbar1.Value = $pct
$form.Refresh()
$secret = Get-AzKeyVaultSecret -VaultName $KeyVault -name $secretName.Name 
$secretvalue = Get-AzKeyVaultSecret -VaultName $KeyVault -name $secretName.Name -AsPlainText


if($SecretorKey -match 'secret')
{
if($secretvalue -Match $value)
{
$label1.Text = Write-Output "Found match"
$label1.Text = Write-Output "Secret Name is:" $secret.Name
$label1.Text = Write-Output "Secret Value is:" $secretvalue
#$textBox5.Text = $textBox5.Text + ( Write-Output "Secret Name is:" $secret.Name) + "`r`n" 
#$textBox5.Text = $textBox5.Text + (Write-Output "Secret Value is:" $secretvalue) + "`r`n" 
#$textBox5.Text = $textBox5.Text + "======================================="  + "`r`n`r`n"
$listBox.Items.Add(('Name:')  + $secret.Name + (' Value:') + $secretvalue) 
$hash.Add($secret.Name, $secretvalue)
$keys.Add($secret.Name)
$label1.Text = Write-Output "Searching more...."
}
}
elseif($SecretorKey -match 'Key')
{
if($secret.Name -Match $value)
{

$label1.Text = Write-Output "Found match"
$label1.Text = Write-Output "Secret Name is:" $secret.Name
$label1.Text = Write-Output "Secret Value is:" $secretvalue
#$textBox5.Text = $textBox5.Text +( Write-Output "Secret Name is:" $secret.Name) + "`r`n" 
#$textBox5.Text = $textBox5.Text +(Write-Output "Secret Value is:" $secretvalue) + "`r`n"
#$textBox5.Text = $textBox5.Text + "======================================"  + "`r`n`r`n" 
$listBox.Items.Add(('Name:')  + $secret.Name + (' Value:') + $secretvalue) 
$hash.Add($secret.Name, $secretvalue)
$keys.Add($secret.Name)
$label1.Text = Write-Output "Searching more...."
}
}
$counter = $counter + 1
}
$label1.Text = Write-Output "Search Completed"
$textBox5.Enabled = $true
$exportButton.Enabled = $true
$updateButton.Enabled = $true


$form.Refresh()
}
catch
{$label1.Text = Write-Output "An error occurred:"
  $label1.Text = Write-Output $_
}
       
}

Function updatesecret
{
try
{
 $progressbar1.Value = 0
 $form.Refresh()
$selectedIndices = $listbox.SelectedIndices
#$label2.Text = "Updating selected " + (Write-Output $selectedIndices.count) + " key(s)"

$counter1 = 1
foreach($indices in $selectedIndices)
{
$label2.text = ""
$label2.Text = "Updating selected key(s)...."


$listcount = $selectedIndices.count
$key = $keys[$indices]
$label2.text = Write-Output "Updating.. ($counter1/$listcount)"
$secretvalue = ConvertTo-SecureString $textBox5.Text -AsPlainText -Force
$secret = Set-AzKeyVaultSecret -VaultName $DropDown2.Text -Name $key -SecretValue $secretvalue
[int]$pct = ($counter1/$selectedIndices.Count)*100
#update the progress bar
$progressbar1.Value = $pct
$counter1 = $counter1 + 1

$form.Refresh()

}

$label2.Text = "Updated " + (Write-Output $selectedIndices.count) + " key(s)" + "`r`n" 

}
catch
{$label2.Text = Write-Output "An error occurred:"
  $label2.Text = Write-Output $_
      
}
}

$form.Controls.Add($okButton)
$form.Topmost = $true
$form.ShowDialog()
    
}

