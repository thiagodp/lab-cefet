@echo off

REM Checa se é Administrador
net session >nul 2>&1 || (echo Este script deve ser executado como Administrador && exit 1)
cd C:\dev || (mkdir C:\dev && cd dev) || exit

call install

call extra-editor
call extra-java
call extra-python
call extra-office
call extra-ops
