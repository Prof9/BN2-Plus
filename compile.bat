@echo off
armips.exe src.asm -sym roms\out.sym
if errorlevel 1 pause