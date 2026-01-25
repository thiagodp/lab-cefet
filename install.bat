@echo off
REM ===========================================================================
REM Script de instalação - Thiago Delgado Pinto
REM ===========================================================================
REM Programas incluídos:
REM cURL, Git, PHP, MariaDB, Apache, PHPMyAdmin, Composer, NodeJS, Bun, scrcpy, Putty, PNPM
REM
REM Os programas são instalados dentro do diretório "C:\dev" (ex. C:\dev\git).
REM
REM Comentários:
REM O comando SETX trunca em 1024 caracteres. Por isso, as variáveis de ambiente devem ser modificadas via "reg add".
REM Como seria preciso reiniciar o terminal para as alterações terem efeito, adiciona-se o caminho no PATH temporariamente via SET. Exemplo:
REM ---
REM for /f "tokens=2*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "%%j;C:\exemplo" /f
REM set PATH=%PATH%;C:\exemplo
REM ---
REM
REM Observações:
REM     - Por algum motivo os seguintes programas fazem terminar a execução do script, dando erro ou não: composer, pnpm, npm
REM         - Para não haver problema quanto ao Composer, utilizou-se a execução via PHP;
REM         - Para não haver problema quanto ao PNPM/NPM, eles foram colocados no fim do script.
REM ===========================================================================

REM Checa se é Administrador
net session >nul 2>&1 || (echo Este script deve ser executado como Administrador && exit 1)

cd C:\dev || (mkdir C:\dev && cd dev) || exit

REM ---------------------------------------------------------------------------

REM Produz variável %DT% com data e hora atual:
set DT=%date:~10,4%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%%time:~6,2%

REM Faz backup do registro do Windows, por segurança
REM reg export "HKLM\SOFTWARE" "%CD%\registro_%DT%.reg" /y

echo Instalando cURL se preciso...
curl --version || winget install -e --id cURL.cURL -l C:\dev\curl

echo Instalando Git se preciso...
git --version || winget install -e --id Git.Git -l C:\dev\git && git config --global --add safe.directory *

echo Desinstalando XAMPP se existir...
(winget list --name XAMPP | findstr XAMPP) && echo Desinstalando XAMP... && winget uninstall --name XAMPP

echo Instalando/atualizando o PHP...
(winget list -e --id PHP.PHP.8.1 | findstr PHP.PHP.8.1) && winget uninstall -e --id PHP.PHP.8.1
(winget list -e --id PHP.PHP.8.2 | findstr PHP.PHP.8.2) && winget uninstall -e --id PHP.PHP.8.2
(winget list -e --id PHP.PHP.8.3 | findstr PHP.PHP.8.3) && winget uninstall -e --id PHP.PHP.8.3
(winget list -e --id PHP.PHP.8.4 | findstr PHP.PHP.8.4) && winget uninstall -e --id PHP.PHP.8.4

winget install -e --id PHP.PHP.8.5 -l C:\dev\php
REM Adiciona ao PATH temporário apenas se não existir
( PATH | findstr C:\dev\php ) || set PATH=%PATH%;C:\dev\php

echo Instalando Apache HTTP se preciso...
winget install -e --id ApacheLounge.httpd -l C:\dev\apache
REM Adiciona ao PATH temporário apenas se não existir
( PATH | findstr C:\dev\apache\Apache24\bin ) || set PATH=%PATH%;C:\dev\apache\Apache24\bin

echo Integrando PHP e Apache...
cd C:\dev && git clone https://github.com/thiagodp/apache-php && cd apache-php && php integrate.php && cd .. && rmdir /Q /S apache-php

echo Instalando Composer se preciso...
php C:\dev\composer\composer.phar --version || (mkdir C:\dev\composer || cd C:\dev\composer) && (
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');"
)

echo Ajustando atalho...
cd C:\dev\composer && echo @php "C:\dev\composer\composer.phar" %%*>composer.bat

REM Adiciona ao PATH persistente apenas se não existir

( reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path | findstr C:\dev\composer ) || (
    setlocal enabledelayedexpansion
    for /f "tokens=*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path ') do (
        for /f "tokens=3*" %%i in ("%%A") do set "currentPath=%%j"
    )
    if not defined currentPath set "currentPath="
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "!currentPath!;C:\dev\composer" /f >nul
)
REM Adiciona ao PATH temporário apenas se não existir
( PATH | findstr C:\dev\composer ) || set PATH=%PATH%;C:\dev\composer


echo Instalando PHPMyAdmin se preciso...
cd C:\dev\apache\Apache24\htdocs\phpmyadmin || (cd C:\dev\apache\Apache24\htdocs && php C:\dev\composer\composer.phar create-project phpmyadmin/phpmyadmin --no-dev)

echo Instalando o Apache como serviço e iniciando...
httpd -k install && httpd -k start


echo Instalando MariaDB se preciso...
(winget list -e --id MariaDB.Server | findstr MariaDB.Server) || winget install --id MariaDB.Server -l C:\dev\mariadb
REM Adiciona ao PATH persistente apenas se não existir
( reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path | findstr C:\dev\mariadb\bin ) || (
    setlocal enabledelayedexpansion
    for /f "tokens=*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path ^| findstr "    Path    REG_EXPAND_SZ"') do (
        for /f "tokens=3*" %%i in ("%%A") do set "currentPath=%%j"
    )
    if not defined currentPath set "currentPath="
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "!currentPath!;C:\dev\mariadb\bin" /f >nul
)
REM Adiciona ao PATH temporário apenas se não existir
(PATH | findstr C:\dev\mariadb\bin) || set PATH=%PATH%;C:\dev\mariadb\bin

echo Instalando o serviço do MariaDB e iniciando...
mysqld --install
sc start MySQL

echo Definindo a senha 'root' para o usuário root do MySQL ...
mysql -u root --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY 'root'; FLUSH PRIVILEGES;"


echo Atualizando o NodeJS...
(winget list -e --id OpenJS.NodeJS.LTS | findstr OpenJS.NodeJS.LTS) && echo Desinstalando NodeJS... && winget uninstall -e --id OpenJS.NodeJS.LTS
cd C:\dev && ((mkdir node && cd node) || cd node) && (winget install -e --id OpenJS.NodeJS.LTS -l C:\dev\node || echo NodeJS OK)

echo Atualizando o Bun...
(winget list -e --id Oven-sh.Bun | findstr Oven-sh.Bun) && echo Desinstalando Bun... && winget uninstall -e --id Oven-sh.Bun
cd C:\dev && winget install -e --id Oven-sh.Bun -l C:\dev\bun

echo Instalando o Putty se preciso...
(winget list -e --id PuTTY.PuTTY | findstr PuTTY.PuTTY) || winget install --id PuTTY.PuTTY -l C:\dev\putty

echo Instalando o Screencopy para desenvolvimento para Android...
winget install --exact Genymobile.scrcpy -m C:\dev\scrcpy

echo Atualizando o PNPM se necessário...
pnpm --version || npm i -g pnpm

cd C:\dev && dir
echo Pronto.
