# Get-TextFromPicture
This PowerShell script is a demostration of getting text from picture with OCR functionality provided from Windows.Media.Ocr.OcrEngine. This is available on Windows 10.

For more information, please visit https://docs.microsoft.com/en-us/uwp/api/windows.media.ocr.ocrengine

The language that is supported by the OcrEngine depends on what language is installed on your Windows 10 box. The script will detect the available languages and you will be able to select it from the drop down menu.

Within my code, there is a function call Get-TextFromPicture, which is actually taken from https://github.com/HumanEquivalentUnit/PowerShell-Misc/blob/master/Get-Win10OcrTextFromImage.ps1 and i modified it a bit to suit my needs. Credit goes to https://github.com/HumanEquivalentUnit for that.

The drag and drop functionality in this form was copied and modified with reference to https://www.rlvision.com/blog/a-drag-and-drop-gui-made-with-powershell/ , credit goes to https://github.com/rlv-dan

The GUI is created with the help of PowerShell Pro Tools, more info available at https://ironmansoftware.com/powershell-pro-tools/

To make use of the script, download both Get-TextFromPicture.ps1 and Get-TextFromPicture.designer.ps1 to the same directory and run Get-TextFromPicture.ps1
