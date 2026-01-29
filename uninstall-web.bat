@echo off
REM Script de desinstalação - Thiago Delgado Pinto

net session >nul 2>&1 || (echo E' preciso executar como Administrador && exit 1)

cd C:\dev || (mkdir C:\dev && cd dev) || exit

REM ---------------------------------------------------------------------------

echo Desinstalando - por favor, aguarde...
winget uninstall --nowarn -e --id cURL.cURL
winget uninstall --nowarn -e --id Git.Git
winget uninstall --name XAMPP
winget uninstall --nowarn -e --id PHP.PHP.8.1
winget uninstall --nowarn -e --id PHP.PHP.8.2
winget uninstall --nowarn -e --id PHP.PHP.8.3
winget uninstall --nowarn -e --id PHP.PHP.8.4
winget uninstall --nowarn -e --id PHP.PHP.8.5

httpd -k stop
httpd -k uninstall
winget uninstall --nowarn -e --id ApacheLounge.httpd

sc stop MySQL
mysqld --uninstall
winget uninstall --nowarn -e --id MariaDB.Server

npm uninstall -g pnpm

winget uninstall --nowarn -e --id OpenJS.NodeJS.LTS
winget uninstall --nowarn -e --id Oven-sh.Bun
winget uninstall --nowarn -e --id PuTTY.PuTTY
winget uninstall --nowarn -e --id Genymobile.scrcpy


rmdir /Q /S C:\dev\apache\htdocs\phpmyadmin
rmdir /Q /S C:\dev\composer
rmdir /Q /S C:\dev\mariadb

cd C:\dev && dir
echo Pronto.