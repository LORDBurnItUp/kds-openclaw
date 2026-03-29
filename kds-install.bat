@echo off
title KDS OpenClaw Installer
color 0A

echo.
echo  ====================================================
echo   KDS OpenClaw Auto-Installer
echo   For Windows 10/11
echo  ====================================================
echo.
echo  This will install:
echo   - Git, Node.js, Python (if missing)
echo   - OpenClaw + Kilo CLI
echo   - All skills and tools
echo   - Ollama for local AI
echo.
echo  Press any key to start...
pause >nul

powershell -ExecutionPolicy Bypass -NoProfile -Command "& { irm https://raw.githubusercontent.com/LORDBurnItUp/kds-openclaw/main/kds-bootstrap-windows.ps1 | iex }"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo  Trying local script instead...
    powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0kds-bootstrap-windows.ps1"
)

echo.
echo  Done! Check the output above for next steps.
pause
