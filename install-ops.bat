@echo off

cd C:\ops || (mkdir C:\ops && C:\ops)

echo Windows Subsystem for Linux (WSL)
winget install -e --id Microsoft.WSL -l C:\ops\wsl

echo PowerShell
winget install -e --id Microsoft.PowerShell -l C:\ops\ps

echo Windows Terminal
winget install -e --id Microsoft.WindowsTerminal  -l C:\ops\wt

echo Ubuntu para WSL
winget install -e --id Canonical.Ubuntu -l C:\ops\ubuntu

echo Docker Desktop
winget install -e --id Docker.DockerDesktop -l C:\ops\docker-desktop


echo Desinstala o VirtualBox se existir...
(winget list -e --id Oracle.VirtualBox | findstr Oracle.VirtualBox) && winget uninstall -e --id Oracle.VirtualBox

echo Limpa o cache do Winget para instalar o VirtualBox
winget source reset --force

echo Instalando Virtual Box...
winget install -e  --id=Oracle.VirtualBox --force --accept-package-agreements --accept-source-agreements -l C:\ops\virtualbox
