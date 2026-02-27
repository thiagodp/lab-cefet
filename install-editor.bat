@echo off
echo -- EDITOR ----------------------------------------------------------------

echo Notepad++
winget install -e --id Notepad++.Notepad++ -l C:\dev\notepad

REM Concede acesso RX ao usuário Aluno, se esse usuário existir...
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\notepad /T /grant Aluno:(RX,RD,RA)


echo VSCode
winget install -e --id Microsoft.VisualStudioCode -l C:\dev\vscode

REM Coloca o vscode no PATH temporário, se não estiver, para instalar extensões
( PATH | findstr C:\dev\vscode ) || set PATH=%PATH%;C:\dev\vscode

echo Extensões do VSCode
for %%E in (
    ritwickdey.liveserver
    rangav.vscode-thunder-client
    qwtel.sqlite-viewer
    bmewburn.vscode-intelephense-client
) do (
    call code --install-extension %%E
)

REM Concede acesso RX ao usuário Aluno, se esse usuário existir...
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\vscode /T /grant Aluno:(RX,RD,RA)