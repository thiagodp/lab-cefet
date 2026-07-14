
@echo off
echo -- PYTHON ----------------------------------------------------------------

echo Python
winget install -e --id Python.Python.3.14 -l C:\dev\python

REM Concede acesso RX ao usuário Aluno, se esse usuário existir...
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\python /T /grant Aluno:(RX,RD,RA) >>saida.txt


echo Anaconda
winget install -e --id Anaconda.Anaconda3 -l C:\dev\anaconda

REM Concede acesso RX ao usuário Aluno, se esse usuário existir...
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\anaconda /T /grant Aluno:(RX,RD,RA) >>saida.txt
