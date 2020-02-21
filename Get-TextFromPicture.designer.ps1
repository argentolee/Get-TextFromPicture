$form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$button = $null
[System.Windows.Forms.CheckBox]$checkbox = $null
[System.Windows.Forms.Label]$Label1 = $null
[System.Windows.Forms.ListBox]$listBox = $null
[System.Windows.Forms.ComboBox]$ComboBox1 = $null
[System.Windows.Forms.TextBox]$TextBox1 = $null
[System.Windows.Forms.Label]$Label2 = $null
[System.Windows.Forms.Label]$Label3 = $null
function InitializeComponent
{
$button = (New-Object -TypeName System.Windows.Forms.Button)
$checkbox = (New-Object -TypeName System.Windows.Forms.CheckBox)
$Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$listBox = (New-Object -TypeName System.Windows.Forms.ListBox)
$ComboBox1 = (New-Object -TypeName System.Windows.Forms.ComboBox)
$TextBox1 = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label2 = (New-Object -TypeName System.Windows.Forms.Label)
$Label3 = (New-Object -TypeName System.Windows.Forms.Label)
$form.SuspendLayout()
#
#button
#
$button.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]474,[System.Int32]54))
$button.Name = [System.String]'button'
$button.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$button.TabIndex = [System.Int32]0
$button.Text = [System.String]'Run OCR'
$button.UseCompatibleTextRendering = $true
$button.UseVisualStyleBackColor = $true
$button.add_Click($Button_Click)
#
#checkbox
#
$checkbox.Checked = $true
$checkbox.CheckState = [System.Windows.Forms.CheckState]::Checked
$checkbox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]437,[System.Int32]12))
$checkbox.Name = [System.String]'checkbox'
$checkbox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]126,[System.Int32]24))
$checkbox.TabIndex = [System.Int32]1
$checkbox.Text = [System.String]'Clear list after run'
$checkbox.UseCompatibleTextRendering = $true
$checkbox.UseVisualStyleBackColor = $true
#
#Label1
#
$Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]15,[System.Int32]36))
$Label1.Name = [System.String]'Label1'
$Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]384,[System.Int32]42))
$Label1.TabIndex = [System.Int32]2
$Label1.Text = [System.String]'Drop File to the box below (JPEG, BMP, PNG, GIF, TIFF) and click Run OCR'
$Label1.UseCompatibleTextRendering = $true
$Label1.add_Click($Label1_Click)
#
#listBox
#
$listBox.AllowDrop = $true
$listBox.Anchor = [System.Windows.Forms.AnchorStyles]::None
$listBox.IntegralHeight = $false
$listBox.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]17,[System.Int32]84))
$listBox.Name = [System.String]'listBox'
$listBox.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]537,[System.Int32]83))
$listBox.TabIndex = [System.Int32]3
$listBox.add_DragDrop($listBox_DragDrop)
$listBox.add_DragOver($listBox_DragOver)
#
#ComboBox1
#
$ComboBox1.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$ComboBox1.FormattingEnabled = $true
$ComboBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]177,[System.Int32]12))
$ComboBox1.Name = [System.String]'ComboBox1'
$ComboBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]243,[System.Int32]21))
$ComboBox1.TabIndex = [System.Int32]4
$ComboBox1.add_SelectedIndexChanged($SelectedIndexChanged)
#
#TextBox1
#
$TextBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]219))
$TextBox1.Multiline = $true
$TextBox1.Name = [System.String]'TextBox1'
$TextBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]537,[System.Int32]305))
$TextBox1.TabIndex = [System.Int32]5
#
#Label2
#
$Label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]193))
$Label2.Name = [System.String]'Label2'
$Label2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$Label2.TabIndex = [System.Int32]6
$Label2.Text = [System.String]'Result:'
$Label2.UseCompatibleTextRendering = $true
#
#Label3
#
$Label3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]17,[System.Int32]13))
$Label3.Name = [System.String]'Label3'
$Label3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]143,[System.Int32]23))
$Label3.TabIndex = [System.Int32]7
$Label3.Text = [System.String]'Select Language for OCR'
$Label3.UseCompatibleTextRendering = $true
#
#form
#
$form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]564,[System.Int32]556))
$form.Controls.Add($Label3)
$form.Controls.Add($Label2)
$form.Controls.Add($TextBox1)
$form.Controls.Add($ComboBox1)
$form.Controls.Add($listBox)
$form.Controls.Add($Label1)
$form.Controls.Add($checkbox)
$form.Controls.Add($button)
$form.Text = [System.String]'OCR'
$form.ResumeLayout($false)
$form.PerformLayout()
Add-Member -InputObject $form -Name base -Value $base -MemberType NoteProperty
Add-Member -InputObject $form -Name button -Value $button -MemberType NoteProperty
Add-Member -InputObject $form -Name checkbox -Value $checkbox -MemberType NoteProperty
Add-Member -InputObject $form -Name Label1 -Value $Label1 -MemberType NoteProperty
Add-Member -InputObject $form -Name listBox -Value $listBox -MemberType NoteProperty
Add-Member -InputObject $form -Name ComboBox1 -Value $ComboBox1 -MemberType NoteProperty
Add-Member -InputObject $form -Name TextBox1 -Value $TextBox1 -MemberType NoteProperty
Add-Member -InputObject $form -Name Label2 -Value $Label2 -MemberType NoteProperty
Add-Member -InputObject $form -Name Label3 -Value $Label3 -MemberType NoteProperty
}
. InitializeComponent
