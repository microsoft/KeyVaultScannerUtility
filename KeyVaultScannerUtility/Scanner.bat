@echo off

powershell.exe -noprofile -NoExit -window minimized -command "&{start-process powershell -ArgumentList '-NoExit -noprofile -window minimized -file "%CD%\KeyVaultscanner.ps1" ' -verb RunAs}"