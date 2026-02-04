@echo off

REM Checa se é Administrador
net session >nul 2>&1 || (echo Este script deve ser executado como Administrador && exit 1)
cd C:\dev || (mkdir C:\dev && cd dev) || exit

REM for %%E in (
REM     install-editor
REM     install-cpp
REM     install-java
REM     install-python
REM     install-office
REM     install-ops
REM     install-web
REM ) do (
REM     call %%E
REM )


install-editor.bat
install-cpp.bat
install-java.bat
install-python.bat
install-office.bat
install-ops.bat
install-web.bat
