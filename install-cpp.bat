
@echo off
echo -- CPP -------------------------------------------------------------------

echo CodeBlocks com MinGW
winget install -e --id CodeBlocks.CodeBlocks.MinGW -l C:\dev\codeblocks
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\codeblocks" /grant Aluno:(OI)(CI)M /T >>saida.txt && icacls "C:\dev\codeblocks" /deny Aluno:(OI)(CI)(DE,DC) /T  >>saida.txt

echo Arduino IDE
winget install -e --id ArduinoSA.IDE.stable -l C:\dev\arduino-ide
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\arduino-ide /T /grant Aluno:(RX,RD,RA) >>saida.txt
