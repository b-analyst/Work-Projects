function solstice {

    $MyApp = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | 
        Get-ItemProperty | Where-Object {$_.DisplayName -match "Windows Agent" } | 
            Select-Object -Property DisplayName, UninstallString
            $uninst = $MyApp.UninstallString 
            & cmd /c $uninst /quiet /norestart

    
    $Creds = Get-Credential -UserName "HBMMJ\install" -Message "Enter your password"
    Start-Process "\\hbmmj\main\data\OK\337WindowsAgentSetup_VALID_UNTIL_2021_03_12.exe" -Credential $Creds
}

solstice