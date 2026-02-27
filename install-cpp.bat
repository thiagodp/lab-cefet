@echo off
echo -- CPP -------------------------------------------------------------------

echo CodeBlocks com MinGW
winget install -e --id CodeBlocks.CodeBlocks.MinGW -l C:\dev\codeblocks

REM Concede acesso RX ao usuário Aluno, se esse usuário existir...
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\codeblocks /T /grant Aluno:(RX,RD,RA)

echo Arduino IDE
winget install -e --id ArduinoSA.IDE.stable -l C:\dev\arduino-ide

REM Concede acesso RX ao usuário Aluno, se esse usuário existir...
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\arduino-ide /T /grant Aluno:(RX,RD,RA)