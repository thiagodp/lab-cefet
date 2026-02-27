@echo off
echo -- JAVA ------------------------------------------------------------------

echo Instalando JDK...
winget install -e --silent --id Oracle.JDK.25 -l C:\dev\jdk

REM Adiciona o JDK ao PATH, via registro, se não existir
( reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH | findstr C:\dev\jdk\bin ) || (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;C:\dev\jdk\bin" /f
)
REM Adiciona o JDK ao PATH temporário, se não existir
( PATH | findstr C:\dev\jdk\bin ) || set PATH=%PATH%;C:\dev\jdk\bin

REM Adiciona a variável JAVA_HOME, via registro, se não existir
( reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" /v JAVA_HOME | findstr C:\dev\jdk ) || (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v JAVA_HOME /t REG_EXPAND_SZ /d "%PATH%;C:\dev\jdk" /f
)

REM Concede acesso RX ao usuário Aluno, se esse usuário existir...
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\jdk /T /grant Aluno:(RX,RD,RA)


echo Instalando Eclipse para JEE...
winget install -e --id EclipseFoundation.Eclipse.JEE -l C:\dev\eclipse

REM Concede acesso RX ao usuário Aluno, se esse usuário existir...
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\eclipse /T /grant Aluno:(RX,RD,RA)


echo Instalando IntelliJ Community...
winget install -e --id JetBrains.IntelliJIDEA.Community -l C:\dev\intellij

REM Concede acesso RX ao usuário Aluno, se esse usuário existir...
(wmic useraccount get name|findstr Aluno) && icacls C:\dev\intellij /T /grant Aluno:(RX,RD,RA)
