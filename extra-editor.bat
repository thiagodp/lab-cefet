@echo off

echo Notepad++
winget install -e --id Notepad++.Notepad++ -l C:\dev\notepad

echo VSCode
winget install -e --id Microsoft.VisualStudioCode -l C:\dev\vscode

REM Coloca o vscode no PATH temporário, se não estiver, para instalar extensões
( PATH | findstr C:\dev\vscode ) || set PATH=%PATH%;C:\dev\vscode

echo Extensões do VSCode

code --install-extension ritwickdey.liveserver
code --install-extension devsense.phptools-vscode
code --install-extension rangav.vscode-thunder-client
code --install-extension qwtel.sqlite-viewer
code --install-extension bmewburn.vscode-intelephense-client
