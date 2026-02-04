@echo off

echo Notepad++
winget install -e --id Notepad++.Notepad++ -l C:\dev\notepad

echo VSCode
winget install -e --id Microsoft.VisualStudioCode -l C:\dev\vscode

REM Coloca o vscode no PATH temporário, se não estiver, para instalar extensões
( PATH | findstr C:\dev\vscode ) || set PATH=%PATH%;C:\dev\vscode

echo Extensões do VSCode
for %%E in (
    ritwickdey.liveserver
    devsense.phptools-vscode
    rangav.vscode-thunder-client
    qwtel.sqlite-viewer
    bmewburn.vscode-intelephense-client
) do (
    call code --install-extension %%E
)
