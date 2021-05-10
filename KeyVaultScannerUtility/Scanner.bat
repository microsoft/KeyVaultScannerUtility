@echo off

pwsh -noprofile -NoExit -window minimized -command "&{start-process pwsh -ArgumentList '-NoExit -noprofile -window minimized -file "%CD%\KeyVaultscanner.ps1" ' -verb RunAs}"
