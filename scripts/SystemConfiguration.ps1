#--- Enable developer mode on the system ---
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name AllowDevelopmentWithoutDevLicense -Value 1

# Disable start suggestion
# https://blog.danic.net/stop-windows-10-enterprise-windows-10-pro-from-advertising-or-installing-unwanted-apps/
# $regHKUPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\"
# Set-ItemProperty -Path $regHKUPath -Name PreInstalledAppsEnabled -Value 0
# You can also set OemPreInstalledAppsEnabled to 0 if you like.
# Set-ItemProperty -Path $regHKUPath -Name OemPreInstalledAppsEnabled -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0

# Enable Auto-timezone
#https://social.technet.microsoft.com/Forums/ie/en-US/35ff7602-2064-4b57-b8e0-2a99b1827594/windows-10-issues-with-timezone?forum=win10itprosetup
#http://www.alexandreviot.net/2017/02/08/windows-10-enable-automatic-timezone/
# 3 = enabled, 4 = disabled
# Reference for setting specific timezone: https://www.windowscentral.com/how-change-your-device-time-zone-settings-windows-10
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate" -Name "Start" -Type DWord -Value 3

# --- Windows Security ---
# Enable Windows Defender
#https://www.itechtics.com/enable-disable-windows-defender/
# Failed to work. Should be enabled by default anyway.
# Set-MpPreference -DisableRealtimeMonitoring $false

# Enable Windows Firewall
#https://devblogs.microsoft.com/scripting/powertip-use-powershell-to-enable-the-windows-firewall/
# Should be enabled by default.
# Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# Enable Show a notification when your PC requires a restart to finish updating
#https://www.tenforums.com/tutorials/76305-turn-off-windows-update-restart-notifications-windows-10-a.html
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "RestartNotificationsAllowed2" -Type DWord -Value 1

# Set screensaver timeout to 5 mintues and display log-on screen
#https://stackoverflow.com/questions/49791065/silently-set-the-screensaver-on-windows-from-the-command-line
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveActive" -Type String -Value 1
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaverIsSecure" -Type String -Value 1
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveTimeOut" -Type String -Value 300