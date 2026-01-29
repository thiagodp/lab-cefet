@echo off

REM Checa se é Administrador
net session >nul 2>&1 || (echo Este script deve ser executado como Administrador && exit 1)
cd C:\dev || (mkdir C:\dev && cd dev) || exit

call install-editor.bat
call install-cpp.bat
call install-java.bat
call install-python.bat
call install-office.bat
call install-ops.bat
call install-web.bat