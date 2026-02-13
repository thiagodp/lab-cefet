@echo off
echo -- INSTALL ---------------------------------------------------------------

REM Checa se é Administrador
net session >nul 2>&1 || (echo Este script deve ser executado como Administrador && exit 1)
cd C:\dev || (mkdir C:\dev && cd dev) || exit

for %%E in (
    install-editor
    install-cpp
    install-java
    install-python
    install-office
    install-ops
    install-web
) do (
    call %%E
)
