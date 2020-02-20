# Set screensaver timeout to 5 mintues and display log-on screen
#https://stackoverflow.com/questions/49791065/silently-set-the-screensaver-on-windows-from-the-command-line
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveActive" -Type String -Value 1
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaverIsSecure" -Type String -Value 1
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveTimeOut" -Type String -Value 300