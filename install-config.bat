
REM Configuração básica para instalação de outros programas
REM -------------------------------------------------------

@echo off
echo -- CONFIG ----------------------------------------------------------------

REM Checa se é Administrador
net session >nul 2>&1 || (echo Este script deve ser executado como Administrador && exit 1)

REM Permite instalar com WinGet programas que estejam fora da Microsoft Store
REM Útil em caso de erro ao tentar instalar algo com o WinGet
winget settings --disable BypassCertificatePinningForMicrosoftStore

REM Habilita a instalação via manifestos locais (precisa ser Administrador)
winget settings --enable LocalManifestFiles

REM Habilita o WMIC
dism /Online /Add-Capability /CapabilityName:wmic
