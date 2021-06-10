$cred = Get-Credential -UserName 'HBMMJ\install' -Message ' '
Start-Process Powershell.exe -Credential $cred 
