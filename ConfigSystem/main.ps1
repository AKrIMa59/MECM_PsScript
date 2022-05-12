#désactivation de la mise en veille du pc windows et de l'hibernation
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /H off


#activation de SMBv1 si désactivé
$SMB1=Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol-Client
if ("Disabled" -eq $SMB1.State) {
    Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol-Client -NoRestart
}

#Activation de .NET 3.5
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /quiet /NoRestart

#Activation registre à distance
Set-Service -Name RemoteRegistry -StartupType Automatic
Set-Service -Name RemoteRegistry -Status Running
