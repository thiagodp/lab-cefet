@echo off

del lab.bat
echo Gerando lab.bat...
type install-editor.bat>>lab.bat
type install-cpp.bat>>lab.bat
type install-java.bat>>lab.bat
type install-python.bat>>lab.bat
type install-office.bat>>lab.bat
type install-ops.bat>>lab.bat
type install-web.bat>>lab.bat