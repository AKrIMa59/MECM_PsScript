#désactivation de la mise en veille du pc windows et de l'hibernation
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /H off


#activation de SMBv1 si désactivé
$SMB1=Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
if ("Disabled" -eq $SMB1.State) {
    Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol-Server -NoRestart
}

#activation de telnet si désactivé
$Telnet=Get-WindowsOptionalFeature -Online -FeatureName TelnetClient
if ("Disabled" -eq $Telnet.State) {
    Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient -NoRestart
}

#désactivation de Printing-XPSServices-Features
$PrintingXPSServicesFeatures=Get-WindowsOptionalFeature -Online -FeatureName Printing-XPSServices-Features
if ("Enabled" -eq $PrintingXPSServicesFeatures.State) {
    Disable-WindowsOptionalFeature -Online -FeatureName Printing-XPSServices-Features -NoRestart
}

#Activation de .NET 3.5
$NetFx3=Get-WindowsOptionalFeature -Online -FeatureName NetFx3
if ($NetFx3.State -like "*Disabled*") {
    Set-Itemproperty -path 'HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name "UseWUServer" -Value 0
    Restart-Service -Name "wuauserv"
    Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -NoRestart
    Set-Itemproperty -path 'HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name "UseWUServer" -Value 1
    Restart-Service -Name "wuauserv"
}

#Désactivation de la gestion des imprimantes par windows
Set-Itemproperty -path 'HKCU:SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows' -Name "LegacyDefaultPrinterMode" -Value 1

#Activation registre à distance
Set-Service -Name RemoteRegistry -StartupType Automatic
Set-Service -Name RemoteRegistry -Status Running
