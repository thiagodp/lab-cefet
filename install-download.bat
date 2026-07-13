REM ------------------------------------------------------------------------------------------------
REM Baixa alguns programas para instalação:
REM - Portugol 2.27.5     : baixa e inicia o instalador
REM - Astah Community 6.9 : baixa e copia para "C:\dev\astah-community" caso essa pasta não exista.
REM ------------------------------------------------------------------------------------------------

@echo off
echo -- DOWNLOAD --------------------------------------------------------------

REM Portugol

echo Baixando Portugol...
dir portugol-setup.exe || php download.php https://github.com/UNIVALI-LITE/Portugol-Studio/releases/download/v2.7.5/portugol-studio-2.7.5-windows.exe portugol-setup.exe
echo Iniciando a instalação...
start portugol-setup.exe


REM Astah Community

dir C:\dev\astah-community || (echo Baixando Astah Community... && (dir astah.zip || php download.php https://gitlab.com/thiagodp/astah/-/raw/main/astah-community-6_9_0-b4c6e9.zip?inline=false astah.zip) && (php unzip.php astah.zip C:\dev\astah-community))
