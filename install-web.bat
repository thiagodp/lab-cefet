
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
REM Para conceder permissões de modificação e exclusão com icalcls, de forma recursiva:
REM icacls "C:\exemplo" /grant Aluno:(OI)(CI)M /T
REM
REM Para remover a permissão de remoção de pasta e arquivos recursivamente:
REM icacls "C:\exemplo" /deny Aluno:(OI)(CI)(DE,DC) /T
REM
REM Observações:
REM     - Alguns programas (ex. Code, Composer, PNPM e NPM) fazem terminar a execução do script, pois são
REM       arquivos bat/cmd/ps e o controle da execução passam para os mesmos. Para solucionar, deve-se
REM       usar "call" para invocar o respectivo programa. Ex.: call code
REM
REM     - Sobre o uso do icacls, consultar https://ss64.com/nt/icacls.html
REM ===========================================================================


@echo off
echo -- WEB -------------------------------------------------------------------

REM Checa se é Administrador
net session >nul 2>&1 || (echo Este script deve ser executado como Administrador && exit 1)

REM Permite instalar com WinGet programas que estejam fora da Microsoft Store
REM Pode ser útil em caso de erro ao tentar instalar algo com o WinGet:

winget settings --disable BypassCertificatePinningForMicrosoftStore


cd C:\dev || (mkdir C:\dev && cd dev) || exit

REM ---------------------------------------------------------------------------

REM Produz variável %DT% com data e hora atual:
REM set DT=%date:~10,4%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%%time:~6,2%

REM Faz backup do registro do Windows, por segurança
REM reg export "HKLM\SOFTWARE" "%CD%\registro_%DT%.reg" /y

REM ---------------------------------------------------------------------------
REM Desinstala programas que não devem estar instalados

REM (winget list -e --id ApacheFriends.Xampp.8.1 | findstr ApacheFriends.Xampp.8.1) && winget uninstall -e --id ApacheFriends.Xampp.8.1 --silent
REM (winget list -e --id ApacheFriends.Xampp.8.2 | findstr ApacheFriends.Xampp.8.2) && winget uninstall -e --id ApacheFriends.Xampp.8.2 --silent
REM Basta um comando de desinstalação do XAMPP. Infelizmente ele pede confirmação, mesmo com --silent.
(winget list --name XAMPP | findstr XAMPP) && winget uninstall --name XAMPP  --silent

(winget list -e --id Wampserver.Wampserver | findstr Wampserver.Wampserver) && winget uninstall -e --id Wampserver.Wampserver  --silent

(winget list -e --id PHP.PHP.8.1 | findstr PHP.PHP.8.1) && winget uninstall -e --id PHP.PHP.8.1 --silent
(winget list -e --id PHP.PHP.8.2 | findstr PHP.PHP.8.2) && winget uninstall -e --id PHP.PHP.8.2 --silent
(winget list -e --id PHP.PHP.8.3 | findstr PHP.PHP.8.3) && winget uninstall -e --id PHP.PHP.8.3 --silent
(winget list -e --id PHP.PHP.8.4 | findstr PHP.PHP.8.4) && winget uninstall -e --id PHP.PHP.8.4 --silent

REM ---------------------------------------------------------------------------

REM cURL

echo Instalando cURL se preciso...
curl --version || winget install -e --id cURL.cURL -l C:\dev\curl
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\curl" /T /grant Aluno:(RX,RD,RA) >>saida.txt


REM Git

echo Instalando Git se preciso...
git --version || winget install -e --id Git.Git -l C:\dev\git && git config --global --add safe.directory *
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\git" /grant Aluno:(OI)(CI)M /T >>saida.txt && icacls "C:\dev\git" /deny Aluno:(OI)(CI)(DE,DC) /T >>saida.txt


REM PHP

echo Instalando/atualizando o PHP...
winget install -e --id PHP.PHP.8.5 -l C:\dev\php
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\php" /grant Aluno:(OI)(CI)M /T >>saida.txt && icacls "C:\dev\php" /deny Aluno:(OI)(CI)(DE,DC) /T >>saida.txt
REM Adiciona ao PATH, via registro, se não existir
( reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH | findstr C:\dev\php ) || (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;C:\dev\php" /f
)
REM Adiciona ao PATH temporário apenas se não existir
( PATH | findstr C:\dev\php ) || set PATH=%PATH%;C:\dev\php


REM Apache (sem serviço)

echo Instalando Apache HTTP se preciso...
winget install -e --id ApacheLounge.httpd -v 2.4.66 -l C:\dev\apache --accept-package-agreements --accept-source-agreements
REM Ajusta acesso à pasta apache
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\apache" /grant Aluno:(OI)(CI)M /T >>saida.txt && icacls "C:\dev\apache" /deny Aluno:(OI)(CI)(DE,DC) /T >>saida.txt
REM Ajusta acesso à pasta apache\Apache24\htdocs - para poder fazer tudo dentro dela, mas não excluí-la
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\apache\Apache24\htdocs" /grant:r "Aluno:(OI)(CI)(IO)(M)" >>saida.txt
REM Adiciona ao PATH temporário apenas se não existir
( PATH | findstr C:\dev\apache\Apache24\bin ) || set PATH=%PATH%;C:\dev\apache\Apache24\bin


REM Integração de Apache com PHP

echo Integrando PHP e Apache...
(cd C:\dev\apache-php || (cd C:\dev && git clone https://github.com/thiagodp/apache-php && cd apache-php)) && php integrate.php --silent
REM Ajusta acesso - RX
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\apache-php" /T /grant Aluno:(RX,RD,RA) >>saida.txt


REM echo Instalando Composer se preciso...
REM php C:\dev\composer\composer.phar --version || (mkdir C:\dev\composer || cd C:\dev\composer) && (
REM     php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');"
REM )
REM echo Ajustando atalho...
REM cd C:\dev\composer && echo @php "C:\dev\composer\composer.phar" %%*>composer.bat


REM Composer

echo Instalando Composer se preciso...
php C:\dev\composer\composer.phar --version || ((mkdir C:\dev\composer || cd C:\dev\composer) && (
    cd C:\dev\composer && (curl -sS https://getcomposer.org/installer | php) && php composer-setup.php --filename=composer.bat
))
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\composer /T /grant Aluno:(RX,RD,RA) >>saida.txt
REM Adiciona Composer ao PATH, via registro, se não existir
( reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH | findstr C:\dev\composer ) || (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;C:\dev\composer" /f
)
REM Adiciona Composer ao PATH temporário, se não existir
( PATH | findstr C:\dev\composer ) || set PATH=%PATH%;C:\dev\composer


REM PHPMyAdmin

echo Instalando PHPMyAdmin se preciso...
cd C:\dev\apache\Apache24\htdocs\phpmyadmin || (cd C:\dev\apache\Apache24\htdocs && php C:\dev\composer\composer.phar create-project phpmyadmin/phpmyadmin --no-dev --ignore-platform-req=ext-curl)


REM Serviço do Apache

echo Instalando o Apache como serviço e iniciando...
httpd -k install && httpd -k start


REM MariaDB (inclui MySQL)

echo Instalando MariaDB se preciso...
(winget list -e --id MariaDB.Server | findstr MariaDB.Server) || ((rmdir /Q /S C:\dev\mariadb || echo Aguarde...) && winget install --id MariaDB.Server -l C:\dev\mariadb)
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\mariadb" /grant Aluno:(OI)(CI)M /T  >>saida.txt && icacls "C:\dev\mariadb" /deny Aluno:(OI)(CI)(DE,DC) /T >>saida.txt
REM Adiciona MariaDB ao PATH, via registro, se não existir
( reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH | findstr C:\dev\mariadb\bin ) || (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;C:\dev\mariadb\bin" /f
)
REM Adiciona MariaDB ao PATH temporário, se não existir
( PATH | findstr C:\dev\mariadb\bin ) || set PATH=%PATH%;C:\dev\mariadb\bin
REM Desinstala o serviço do MariaDB/MySQL se existir
( sc query | find /i "mysql" ) && sc stop MySQL && mysqld --remove
REM Instala serviço e inicia MariaDB/MySQL
echo Instalando o serviço do MariaDB e iniciando...
mysqld --install
sc start MySQL
REM Ajusta a senha
echo Definindo a senha 'root' para o usuário root do MySQL ...
mysql -u root --execute="ALTER USER 'root'@'localhost' IDENTIFIED BY 'root'; FLUSH PRIVILEGES;"


REM NodeJS

echo Atualizando o NodeJS...
(winget list -e --id OpenJS.NodeJS.LTS | findstr OpenJS.NodeJS.LTS) && echo Desinstalando NodeJS... && winget uninstall -e --id OpenJS.NodeJS.LTS
cd C:\dev && winget install -e --id OpenJS.NodeJS.LTS -l C:\dev\node
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\node /T /grant Aluno:(RX,RD,RA) >>saida.txt


REM Bun

echo Atualizando o Bun...
(winget list -e --id Oven-sh.Bun | findstr Oven-sh.Bun) && echo Desinstalando Bun... && winget uninstall -e --id Oven-sh.Bun
cd C:\dev && winget install -e --id Oven-sh.Bun -l C:\dev\bun
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\bun /T /grant Aluno:(RX,RD,RA)


REM Putty

echo Instalando o Putty se preciso...
(winget list -e --id PuTTY.PuTTY | findstr PuTTY.PuTTY) || winget install --id PuTTY.PuTTY -l C:\dev\putty
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\putty" /grant Aluno:(OI)(CI)M /T >>saida.txt && icacls "C:\dev\putty" /deny Aluno:(OI)(CI)(DE,DC) /T >>saida.txt


REM Screencopy

echo Instalando o Screencopy para desenvolvimento para Android...
winget install -e --id Genymobile.scrcpy -l C:\dev\scrcpy
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\scrcpy /T /grant Aluno:(RX,RD,RA) >>saida.txt


REM PNPM

echo Atualizando o PNPM se necessário...
call pnpm --version || npm i -g pnpm || winget install -e --id=pnpm.pnpm -l C:\dev\pnpm
REM Ajusta acesso
(wmic useraccount get name|findstr Aluno) && icacls "C:\dev\pnpm" /grant Aluno:(OI)(CI)M /T >>saida.txt && icacls "C:\dev\pnpm" /deny Aluno:(OI)(CI)(DE,DC) /T >>saida.txt


dir C:\dev
echo Pronto.

echo Checando o funcionamento...
call php --version
call composer --version
call node --version
call pnpm --version
call git --version
call curl --version
call start chrome http://localhost
call start chrome http://localhost/phpmyadmin

