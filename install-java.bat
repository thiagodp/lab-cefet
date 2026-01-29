@echo off

echo Instalando JDK...
winget install -e --id Oracle.JDK.25 -l C:\dev\jdk

echo Instalando Eclipse para JEE...
winget install -e --id EclipseFoundation.Eclipse.JEE -l C:\dev\eclipse

echo Instalando IntelliJ Community...
winget install -e --id JetBrains.IntelliJIDEA.Community -l C:\dev\intellij
