@echo off

echo Adobe Acrobat
winget install -e --id Adobe.Acrobat.Reader.64-bit -l %PROGRAMFILES%\AdobeReader

echo Chrome
winget install -e --id Chrome.Chrome -l %PROGRAMFILES%\Chrome

echo Firefox
winget install -e --id Mozilla.Firefox.pt-BR -l %PROGRAMFILES%\Firefox

echo IrfanView e plug-ins
winget install -e --id IrfanSkiljan.IrfanView -l %PROGRAMFILES%\IrfanView
winget install -e --id IrfanSkiljan.IrfanView.PlugIns 4.73  -l %PROGRAMFILES%\IrfanView\Plugins

echo Microsoft Office
winget install -e --id Microsoft.Office

echo LibreOffice e ajuda
winget install -e --id TheDocumentFoundation.LibreOffice -l %PROGRAMFILES%\LibreOffice
winget install -e --id TheDocumentFoundation.LibreOffice.HelpPack -l %PROGRAMFILES%\LibreOffice\HelpPack
