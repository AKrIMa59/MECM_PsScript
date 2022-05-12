#désactivation de la mise en veille du pc windows et de l'hibernation
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /H off


#activation de SMBv1 si désactivé
$SMB1=Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
if ("Disabled" -eq $SMB1.State) {
    Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
}

#Activation de .NET 3.5
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All

