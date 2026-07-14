
@echo off
echo -- OTHER -----------------------------------------------------------------

REM MySQL Workbench

(winget list -e --id Oracle.MySQLWorkbench | findstr Oracle.MySQLWorkbench) && winget install -e --id Oracle.MySQLWorkbench
