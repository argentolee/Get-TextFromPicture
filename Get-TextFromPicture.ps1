using namespace Windows.Storage
using namespace Windows.Graphics.Imaging
Add-Type -AssemblyName System.Windows.Forms



$SelectedLanguage = $null
$AvailableOCR = $null
$null = [Windows.Media.Ocr.OcrEngine, Windows.Foundation, ContentType = WindowsRuntime]
$AvailableRecognizerLanguages = [Windows.Media.Ocr.OcrEngine]::AvailableRecognizerLanguages
$SelectedLanguage = $null

$SelectedIndexChanged = {
    $SelectedLanguage = $ComboBox1.SelectedItem
    
}


$button_Click = {
    

    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if ($i -is [System.IO.DirectoryInfo]) {
            write-host ("Folder is currently not supported")
        }
        else {
            
            $text = $null
            $statusBar.Text = "Processing..."
            $result = Get-TextFromPicture -Path "$i" -Language $ComboBox1.SelectedItem
            foreach ($line in $result.Lines.Text) {
                
                $text += $line + "`r`n"
            }
            
            $TextBox1.Text = $text
            $statusBar.Text = "Ready..."

          
            
        }
    }

    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }
   
}
$listBox_DragOver = [System.Windows.Forms.DragEventHandler] {
    if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
        
        $_.Effect = 'Copy'
    }
    else {
        $_.Effect = 'None'
    }
}
	
$listBox_DragDrop = [System.Windows.Forms.DragEventHandler] {
    foreach ($filename in $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)) {
        
        $listBox.Items.Clear()
        $listBox.Items.Add($filename)
    }
    
}

$form_FormClosed = {
    try {
        $listBox.remove_Click($button_Click)
        $listBox.remove_DragOver($listBox_DragOver)
        $listBox.remove_DragDrop($listBox_DragDrop)
        $listBox.remove_DragDrop($listBox_DragDrop)
        $form.remove_FormClosed($Form_Cleanup_FormClosed)
    }
    catch [Exception]
    { }
}

#https://github.com/HumanEquivalentUnit/PowerShell-Misc/blob/master/Get-Win10OcrTextFromImage.ps1
function Get-TextFromPicture {

    <#
    .Synopsis
       Runs Windows 10 OCR on an image.
    .DESCRIPTION
       Takes a path to an image file, with some text on it.
       Runs Windows 10 OCR against the image.
       Returns an [OcrResult], hopefully with a .Text property containing the text
    .EXAMPLE
       $result = .\Get-Win10OcrTextFromImage.ps1 -Path 'c:\test.bmp'
       $result.Text
    #>
    [CmdletBinding()]
    Param
    (
        # Path to an image file
        [Parameter(Mandatory = $true, 
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true, 
            Position = 0,
            HelpMessage = 'Path to an image file, to run OCR on')]
        [ValidateNotNullOrEmpty()]
        $Path,
        [Parameter(Mandatory = $true, 
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true, 
            Position = 1,
            HelpMessage = 'Language for OCR')]
        [ValidateNotNullOrEmpty()]
        $Language
    )
    
    Begin {
        # Add the WinRT assembly, and load the appropriate WinRT types
        Add-Type -AssemblyName System.Runtime.WindowsRuntime
    
        $null = [Windows.Storage.StorageFile, Windows.Storage, ContentType = WindowsRuntime]
        $null = [Windows.Media.Ocr.OcrEngine, Windows.Foundation, ContentType = WindowsRuntime]
        $null = [Windows.Foundation.IAsyncOperation`1, Windows.Foundation, ContentType = WindowsRuntime]
        $null = [Windows.Graphics.Imaging.SoftwareBitmap, Windows.Foundation, ContentType = WindowsRuntime]
        $null = [Windows.Storage.Streams.RandomAccessStream, Windows.Storage.Streams, ContentType = WindowsRuntime]
        
        
        
        $ocrEngine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage($Language)
    
        # PowerShell doesn't have built-in support for Async operations, 
        # but all the WinRT methods are Async.
        # This function wraps a way to call those methods, and wait for their results.
        $getAwaiterBaseMethod = [WindowsRuntimeSystemExtensions].GetMember('GetAwaiter').
        Where( {
                $PSItem.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1'
            }, 'First')[0]
    
        Function Await {
            param($AsyncTask, $ResultType)
    
            $getAwaiterBaseMethod.
            MakeGenericMethod($ResultType).
            Invoke($null, @($AsyncTask)).
            GetResult()
        }
    }
    
    Process {
        foreach ($p in $Path) {
          
            # From MSDN, the necessary steps to load an image are:
            # Call the OpenAsync method of the StorageFile object to get a random access stream containing the image data.
            # Call the static method BitmapDecoder.CreateAsync to get an instance of the BitmapDecoder class for the specified stream. 
            # Call GetSoftwareBitmapAsync to get a SoftwareBitmap object containing the image.
            #
            # https://docs.microsoft.com/en-us/windows/uwp/audio-video-camera/imaging#save-a-softwarebitmap-to-a-file-with-bitmapencoder
    
            # .Net method needs a full path, or at least might not have the same relative path root as PowerShell
            $p = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($p)
            
            $params = @{ 
                AsyncTask  = [StorageFile]::GetFileFromPathAsync($p)
                ResultType = [StorageFile]
            }
            $storageFile = Await @params
    
    
            $params = @{ 
                AsyncTask  = $storageFile.OpenAsync([FileAccessMode]::Read)
                ResultType = [Streams.IRandomAccessStream]
            }
            $fileStream = Await @params
    
    
            $params = @{
                AsyncTask  = [BitmapDecoder]::CreateAsync($fileStream)
                ResultType = [BitmapDecoder]
            }
            $bitmapDecoder = Await @params
    
    
            $params = @{ 
                AsyncTask  = $bitmapDecoder.GetSoftwareBitmapAsync()
                ResultType = [SoftwareBitmap]
            }
            $softwareBitmap = Await @params
    
            # Run the OCR
            Await $ocrEngine.RecognizeAsync($softwareBitmap) ([Windows.Media.Ocr.OcrResult])
    
        }
    }
}
    
    

. (Join-Path $PSScriptRoot 'Get-TextFromPicture.designer.ps1')


$form.Add_FormClosed($form_FormClosed)

if ($null -ne $AvailableRecognizerLanguages) {

    $AvailableOCR = $AvailableRecognizerLanguages | Select-Object -ExpandProperty LanguageTag

}

if ($null -ne $AvailableOCR) {
    $ComboBox1.Items.Clear()

    $ComboBox1.BeginUpdate()
    foreach ($language in $AvailableOCR) {
        
        $ComboBox1.Items.AddRange($language)
        
    }
    $ComboBox1.EndUpdate()
    $ComboBox1.DisplayMember = $AvailableOCR
    $ComboBox1.SelectedItem = $ComboBox1.Items[0]
    
    
}

#Add Status bar
$statusBar = New-Object System.Windows.Forms.StatusBar
$statusBar.Name = "statusBar"
$statusBar.Text = "Ready..."
$Form.Controls.Add($statusBar)

$Form.ShowDialog()
