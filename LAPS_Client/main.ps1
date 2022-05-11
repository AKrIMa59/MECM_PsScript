#-----------------------------------------------------------------------------------------------------------------------
#Ce script vérifie si le compte administrateur local existe et si il est actif.
#Puis on install le logiciel LAPS si il n'est pas installé.

#Il est necessaire de lancer ce script en administrateur.
#-----------------------------------------------------------------------------------------------------------------------

$localAdministrator = Get-LocalUser -Name Administrateur
if ($localAdministrator.Enabled -eq "False") {
    #l'administrateur local n'est pas activé
    Enable-LocalUser -Name Administrateur
}

#On vérifie si Local Administrator Password Solution est installé
$laps = Get-CimInstance -Class Win32_Product | Where-Object Name -eq "Local Administrator Password Solution"
if ($null -eq $laps.Name) {
    #Local Administrator Password Solution n'est pas installé
    Write-Output "Local Administrator Password Solution n'est pas installe"
    #On installe Local Administrator Password Solution
    .\LAPS.x64.msi /quiet 
} else {
    Write-Output "Local Administrator Password Solution est deja installe"
}

