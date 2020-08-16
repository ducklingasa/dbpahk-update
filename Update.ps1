Function Get-RedirectedUrl {

    Param (
        [Parameter(Mandatory=$true)]
        [String]$URL
    )

    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()

    If ($response.StatusCode -eq "Found")
    {
        $response.GetResponseHeader("Location")
    }
}

$source = 'https://www.dropbox.com/download?full=1&plat=win';
$destination = '.\.update\DropboxOfflineInstaller.exe';

If ([System.IO.File]::Exists(".\client_version.txt")) 
{
    $status = [IO.File]::ReadAllText(".\client_version.txt") -match '(?<=(\\))[0-9.]+'
}
Else
{
    $status = $false
}
$current_ver = ''
If ($status)
{
    $current_ver = $Matches.Item(0)
}

$status = (Get-RedirectedUrl $source) -match '(?<=(%20))[0-9.]+(?=(%20))'
$new_ver = ''
If ($status)
{
    $new_ver = $Matches.Item(0)
}

If ($new_ver -ne $current_ver)
{
    $client = New-Object System.Net.WebClient;
    $client.UseDefaultCredentials = $true;
    $client.DownloadFile($source, $destination);
    Write-Output "Download completed!"
    '.dbfiles\bin\Dropbox\Client\' + $Matches.Item(0) | Out-File -FilePath .\client_version.txt -NoNewline -Encoding ASCII
}
Else
{
    Write-Output "Download skipped!"
}
