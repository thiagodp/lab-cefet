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
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;C:\exemplo" /f
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

REM Permite instalar com WinGet programas que estejam fora da Microsoft Store
REM Pode ser útil em caso de erro ao tentar instalar algo como WinGet:
REM
REM winget settings --disable BypassCertificatePinningForMicrosoftStore

REM Habilita a instalação via manifestos locais (precisa ser Administrador)
winget settings --enable LocalManifestFiles

cd C:\dev || (mkdir C:\dev && cd dev) || exit

REM ---------------------------------------------------------------------------

REM Produz variável %DT% com data e hora atual:
REM set DT=%date:~10,4%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%%time:~6,2%

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
winget install -e --id ApacheLounge.httpd -v 2.4.65 -l C:\dev\apache --accept-package-agreements --accept-source-agreements

REM Adiciona ao PATH temporário apenas se não existir
( PATH | findstr C:\dev\apache\Apache24\bin ) || set PATH=%PATH%;C:\dev\apache\Apache24\bin



echo Integrando PHP e Apache...
(cd C:\dev\apache-php || (cd C:\dev && git clone https://github.com/thiagodp/apache-php && cd apache-php)) && php integrate.php --silent


REM echo Instalando Composer se preciso...
REM php C:\dev\composer\composer.phar --version || (mkdir C:\dev\composer || cd C:\dev\composer) && (
REM     php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');"
REM )
REM echo Ajustando atalho...
REM cd C:\dev\composer && echo @php "C:\dev\composer\composer.phar" %%*>composer.bat

echo Instalando Composer se preciso...
php C:\dev\composer\composer.phar --version || ((mkdir C:\dev\composer || cd C:\dev\composer) && (
    cd C:\dev\composer && (curl -sS https://getcomposer.org/installer | php) && php composer-setup.php --filename=composer.bat
))

REM Adiciona Composer ao PATH, via registro, se não existir
( reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH | findstr C:\dev\composer ) || (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;C:\dev\composer" /f
)
REM Adiciona Composer ao PATH temporário, se não existir
( PATH | findstr C:\dev\composer ) || set PATH=%PATH%;C:\dev\composer


echo Instalando PHPMyAdmin se preciso...
cd C:\dev\apache\Apache24\htdocs\phpmyadmin || (cd C:\dev\apache\Apache24\htdocs && php C:\dev\composer\composer.phar create-project phpmyadmin/phpmyadmin --no-dev --ignore-platform-req=ext-curl)


echo Instalando o Apache como serviço e iniciando...
httpd -k install && httpd -k start


echo Instalando MariaDB se preciso...
(winget list -e --id MariaDB.Server | findstr MariaDB.Server) || ((rmdir /Q /S C:\dev\mariadb || echo Aguarde...) && winget install --id MariaDB.Server -l C:\dev\mariadb)

REM Adiciona MariaDB ao PATH, via registro, se não existir
( reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH | findstr C:\dev\mariadb\bin ) || (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;C:\dev\mariadb\bin" /f
)
REM Adiciona MariaDB ao PATH temporário, se não existir
( PATH | findstr C:\dev\mariadb\bin ) || set PATH=%PATH%;C:\dev\mariadb\bin

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
winget install -e --id Genymobile.scrcpy -l C:\dev\scrcpy


echo Atualizando o PNPM se necessário...
call pnpm --version || npm i -g pnpm


dir C:\dev
echo Pronto.
