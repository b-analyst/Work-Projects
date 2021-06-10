Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

#Runs through the registry to count number of pulse add-in registry keys 
#found under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\.
function pulse-counter {
    $path = ('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*')
    $incre = 0
    Get-ItemProperty $path | Where DisplayName -like "*Pulse*" | ForEach-Object {$incre++; Write-Host $incre}


    if ($incre -gt 1) {"Pulse ghosts sighted! Requesting immediate backup!`n"
        permissions -event "B"}
    elseif($incre -eq 0) {"Pulse is not installed on this machine. Proceeding to installation...`n" 
        pulse-install}
    else {"No ghosts were found.`n"
        permissions}
    }
    

function permissions {

    param([string]$event = "A")


    #Event A: 

    if ($event -eq "A") {

        $eventTrigger1 = Read-Host -Prompt "Would you like to check for updates? (y/n)"  

        if ($eventTrigger1 -eq 'y') {"Checking for updates..."
            pulse-install} 

        elseif ($eventTrigger1 -eq 'n') {
            $eventTrigger2 = (Read-Host -Prompt "Would you like to initialize DestroyBot instead? (y/n)") 

            if ($eventTrigger2 -eq 'y') {
                $eventTrigger3 = Read-Host -Prompt "`n`nDestroyBot has received your request. Permission to launch? (y/n)"                
                if ($eventTrigger3 -eq 'y') {"`nPermission Granted.`n`n"
                    search-destroy} 
                elseif ($eventTrigger3 -eq 'n') {"Permission Denied.`n`n System shutting down in 5 seconds..."
                    Start-Sleep -s 5 | Write-Host "Goodnight" | Start-Sleep -s 1 | RageQuit} 
                else {"Wrong answer.`n`n System shutting down in 5 seconds..."
                    Start-Sleep -s 5 | Write-Host "Goodnight" | Start-Sleep -s 1 | RageQuit}
                } 

            else {"Self-destruct initiated." 
                self-destruct}
            } 

        else {"Wrong answer. Self-destruct initiated."
            self-destruct}
    
        }

    #Event B:

    if ($event -eq "B") {Write-Host "`nBegin transmission...`n" | Start-Sleep -s 1
        $eventTrigger1 = Read-Host -Prompt "`n`nDestroyBot has received the request. Permission to launch? (y/n)"

        if ($eventTrigger1 -eq 'y') {"`nPermission Granted.`n`n"
            search-destroy}

        elseif ($eventTrigger1 -eq 'n') {"Permission Denied.`n`n System shutting down in 5 seconds..."
            Start-Sleep -s 5 | Write-Host "Goodnight" | Start-Sleep -s 1 | RageQuit}

        else {"Wrong answer.`n`n System shutting down in 5 seconds..."
            Start-Sleep -s 5 | Write-Host "Goodnight" | Start-Sleep -s 1 | RageQuit}

        }
            
    }
    


function self-destruct {

    param([int]$delay = 5, [string]$EventLabel = "Thanks! :')")

    #Setup initial form
    $Counter_Form = New-Object System.Windows.Forms.Form
    $Counter_Form.Text = "System Self-destruct"
    $Counter_Form.Width = 450
    $Counter_Form.Height = 200
    $Counter_Form.WindowState = "Normal"

    #Setup our Normal font
    $normalfont = New-Object System.Drawing.Font("Times New Roman",14)

    #Warning font
    $fontsize = 20
    $warningfont = New-Object System.Drawing.Font(
        "Times New Roman", $fontsize, [System.Drawing.FontStyle](
            [System.Drawing.FontStyle]::Bold)
        )

    #Setup initial label
    $Counter_Label = New-Object System.Windows.Forms.Label
    $Counter_Label.AutoSize = $true
    $Counter_Label.ForeColor = "Red"
    $Counter_Label.Font = $warningfont
    $Counter_Label.Left = 206
    $Counter_Label.Top = 40
    $Counter_Label.Text = $delay
    $Counter_Form.Controls.Add($Counter_Label)

    #Event label
    $Counter_Event_Label = New-Object System.Windows.Forms.Label
    $Counter_Event_Label.AutoSize = $true 
    $Counter_Event_Label.Text = $EventLabel
    $Counter_Event_Label.Location = '180,80' # note we're using a different method to position the text here.
    $Counter_Event_Label.Font = $normalfont

    #Troll OK button
    $Counter_OKButton = New-Object System.Windows.Forms.Button
    $Counter_OKButton.AutoSize = $true 
    $Counter_OKButton.Text = "Ok"
    $Counter_OKButton.Left = 180
    $Counter_OKButton.Top = 80
    $Counter_OKButton.Add_Click({
        
        $Counter_Form.Controls.Remove($Counter_OKButton)
        $Counter_Form.Controls.Add($Counter_Event_Label)

        })
    $Counter_Form.Controls.Add($Counter_OKButton)

    #Kaboom Picture
    $img = [System.Drawing.Image]::Fromfile('\\hbmmj\main\data\dist\pulse\z_fix_pulse_files\kaboom-comic-sticker-31219-300x300.png')
    $pictureBox = new-object Windows.Forms.PictureBox
    $pictureBox.Width = $img.Size.Width
    $pictureBox.Height = $img.Size.Height
    $pictureBox.Image = $img


    while ($delay -gt 0) {
        $Counter_Form.Show()

        if ($delay -le 5) { 
            Start-Sleep -s 1
            $delay -= 1
            $Counter_Label.Text = $delay
            } 

        if ($delay -eq 1) {
            $Counter_form.controls.add($pictureBox)
            $fontsize = 100
            $Counter_Label.Left = 155
            $Counter_Label.Top = 40
            $Counter_Label.Text = "kaboom."
            Start-Sleep -s 2
            $delay -= 1
            }
        }
    
    $Counter_Form.Close()

    RageQuit

    }


function search-destroy {
    $path = ('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*')
    $incre = 0
    
    Write-Host "`n`nInitializing DestroyBot system... Beginning scan for Pulse ghosts."

	#Running through the control panel to find anything that has "Pulse" in its name. This takes the most time to complete.
    #$pulse = Get-WmiObject -Class Win32_Product -filter "Name like '%Pulse%'"

	#If there aren't any, the variable returns null and continues to the next operation
	#If it finds Pulse, it uninstalls it.
    #if ($pulse -eq $null) {"There was nothing for DestroyBot to exorcise. Initializing installation ritual."}

    #else {"Pulse ghosts sighted!! initializing exorcism protocol..."
          #$pulse.Uninstall()
          #if($?) {"Pulse ghosts have been eliminated. Continuuing to installation ritual."
          #    pulse-install}
         # }

    #Deletes any floating registry keys
    $oldver = Get-ChildItem $path | Get-ItemProperty | Where-Object {$_.DisplayName -match "pulse"} |
        Select-Object -Property DisplayName, DisplayVersion, UninstallString 
        
        if ($oldver) {$oldver | Format-List -Property DisplayName, DisplayVersion, UninstallString}
        
        ForEach ($ver in $oldver) {
            if ($ver.UninstallString) {$uninst = $ver.UninstallString
                $uninst, (Get-Location)
                Start-Process -FilePath cmd.exe -ArgumentList '/c', $uninst -NoNewWindow -wait| Out-Null}
            }

        pulse-install
    }

    
function pulse-install {

    #Set PS variable to make InstallPulse.cmd executable with a PS cmdlet.
    $install = {".\InstallPulse" | CMD}

    #Specifying path where InstallPulse.cmd is located.
    set-location -LiteralPath "\\hbmmj\main\data\dist\pulse\"

	#Checking if the previous operation was successful or not. If so, it continues with the installation. If not,
	#it returns the set error message. The error is 99% likely to be caused by not finding the path.
    if($?) {"Performing goat sacrifice..."
        Start-Sleep -s 2
        "Now summoning Pulse"
        Invoke-Command -ScriptBlock $install | Out-Null
        if($?) {"`nIt's alive!!"
            Start-Sleep -s 2}
        else {"`nError! Could not successfully install Pulse!" 
            Start-Sleep -s 2}
        }

    else {"`nSystem failure. I could not locate the Pulse drive."
        Start-Sleep -s 1}

    Write-Host "`nChecking env variables..." 

    #checking if env variables are set correctly.
    if ($Env:PULSEDEV -eq "Y" -or $Env:PULSEURL -eq "http://HBMIAMI01.hbmmj.com:8080") {
        $Env:PULSEDEV = "N" 
        $Env:PULSEURL = "http://PulseApp1.hbmmj.com:8080"
       
        if($?) {"`n`nYour variables were incorrect. I changed them to reflect the correct env settings." 
            Start-Sleep -s 2}
        }

    else {
        "No problems here! You should be good to go.`n`n If you have feedback or feature requests, please get in touch with HB IT." 
        Start-Sleep -s 1 
        Write-Host "`nThank you for using DestroyBot." 
        Start-Sleep -s 2
        }
    
    }

function RageQuit {exit}

pulse-counter




