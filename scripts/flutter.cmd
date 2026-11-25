@echo off
setlocal
set "PUB_CACHE=%~dp0..\.tooling\pub-cache"
if exist "%~dp0..\.tooling\flutter\bin\flutter.bat" (
  call "%~dp0..\.tooling\flutter\bin\flutter.bat" --no-version-check %*
) else (
  where flutter.bat >nul 2>nul
  if errorlevel 1 (
    echo Flutter SDK not found. Install Flutter stable or place it in .tooling/flutter.
    exit /b 1
  )
  call flutter.bat %*
)
exit /b %errorlevel%
