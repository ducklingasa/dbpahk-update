@ECHO OFF
SET ZIP_PATH=C:\Program Files\7-Zip\
SET PATH=%PATH%;%ZIP_PATH%

SET "CLIENT="
FOR /D %%F IN (.dbfiles\bin\Dropbox\Client\*.*) DO IF NOT DEFINED CLIENT SET CLIENT=%%F

MKDIR .\.update

ECHO Current client version is:
ECHO %CLIENT%
ECHO.

ECHO Downloading Dropbox Offline Installer...

POWERSHELL -ExecutionPolicy RemoteSigned -File .\Update.ps1
SET /P NEW_CLIENT=<client_version.txt
ECHO.

IF "%NEW_CLIENT%" == "%CLIENT%" GOTO skip

IF NOT [%CLIENT%] == [] RD /s /q %CLIENT% && DEL .dbfiles\bin\Dropbox\Client\Dropbox*.dll

7z e .\.update\DropboxOfflineInstaller.exe -o.\.update Installer.exe.* | FIND "Extracting archive:"
7z x .\.update\Installer.exe.* -o.\.update | FIND "Extracting archive:"

ROBOCOPY .update\$0 .dbfiles\bin\Dropbox\Client /NFL /NDL /NJH /NJS /NS /NC /E /R:0 /DCOPY:T

SET "CLIENT="
FOR /D %%F IN (.dbfiles\bin\Dropbox\Client\*.*) DO IF NOT DEFINED CLIENT SET CLIENT=%%F

ECHO New client version is:
ECHO %CLIENT%
GOTO end

:skip
ECHO Current client is up to date

:end
RD /s /q .\.update
ECHO.

PAUSE