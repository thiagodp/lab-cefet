
@echo off
echo -- OPS -------------------------------------------------------------------

cd C:\ops || (mkdir C:\ops && C:\ops)

echo Windows Subsystem for Linux (WSL)
winget install -e --id Microsoft.WSL -l C:\ops\wsl

echo PowerShell (se não estiver instalado)
powershell /? || winget install -e --id Microsoft.PowerShell -l C:\ops\ps

echo Windows Terminal
winget install -e --id Microsoft.WindowsTerminal  -l C:\ops\wt

echo Ubuntu para WSL
winget install -e --id Canonical.Ubuntu -l C:\ops\ubuntu

echo Docker Desktop
winget install -e --id Docker.DockerDesktop -l C:\ops\docker-desktop

echo Microsoft VCRedist
winget install -e --id=Microsoft.VCRedist.2005.x64
winget install -e --id=Microsoft.VCRedist.2008.x64
winget install -e --id=Microsoft.VCRedist.2010.x64
winget install -e --id=Microsoft.VCRedist.2012.x64
winget install -e --id=Microsoft.VCRedist.2013.x64
winget install -e --id=Microsoft.VCRedist.2015+.x64

echo Desinstala o VirtualBox se existir...
(winget list -e --id Oracle.VirtualBox | findstr Oracle.VirtualBox) && winget uninstall -e --id Oracle.VirtualBox

echo Limpa o cache do Winget para instalar o VirtualBox
winget source reset --force

echo Instalando Virtual Box...
REM Foi preciso retirar o "-l C:\ops\virtualbox" do comando, pois senão ele não aceita a instalação
winget install -e  --id=Oracle.VirtualBox --force --accept-package-agreements --accept-source-agreements


REM Ajusta permissão
(wmic useraccount get name|findstr Aluno) && icacls "C:\ops" /grant Aluno:(OI)(CI)M /T >>saida.txt && icacls "C:\ops" /deny Aluno:(OI)(CI)(DE,DC) /T >>saida.txt
