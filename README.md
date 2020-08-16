# DropboxPortableAHK client updater
Scripts to automatically download and update the DropBox client used by DropboxPortableAHK

## Prerequisites
Please install [7-Zip](https://www.7-zip.org) from Igor Pavlov.

## Installation
Copy the files ([Update.bat](Update.bat) & [Update.ps1](Update.ps1)) to the root folder of DropboxPortableAHK next to **DropboxPortableAHK.exe**
Configure the 7-Zip location in the Update.bat second line if necessary: `SET ZIP_PATH=C:\Program Files\7-Zip\`

## Usage
Once DropboxPortableAHK is configured, while it is not running just execute the **Update.bat**
If there is a newer DropBox for Windows client is available it downloads and updates the necessary client files:
```
Current client version is:
.dbfiles\bin\Dropbox\Client\103.4.383

Downloading Dropbox Offline Installer...
Download completed!

Extracting archive: .\.update\DropboxOfflineInstaller.exe
Extracting archive: .\.update\Installer.exe.{CC46080E-4C33-4981-859A-BBA2F780F31E}

New client version is:
.dbfiles\bin\Dropbox\Client\104.4.175

Press any key to continue . . .
```
If your client is up-to-date it skips the download process:
```
Current client version is:
.dbfiles\bin\Dropbox\Client\104.4.175

Downloading Dropbox Offline Installer...
Download skipped!

Current client is up to date

Press any key to continue . . .
```
After that you can start **DropboxPortableAHK** as before.

## ChangeLog 
See the [Change Log](CHANGELOG.md) for recent changes.
