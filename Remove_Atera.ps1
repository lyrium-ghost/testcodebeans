$WhatToLookFor = 'Atera'
$ClassesRootAltKey = 'HKLM:\SOFTWARE\Classes\Installer\Products\'
Get-ChildItem $ClassesRootAltKey -Rec -EA SilentlyContinue | ForEach-Object {
$CurrentKey = (Get-ItemProperty -Path $_.PsPath)
If ($CurrentKey -match $WhatToLookFor){
$CurrentKey|Remove-Item -Force
}
}

$UninstallKey = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'
Get-ChildItem $UninstallKey -Rec -EA SilentlyContinue | ForEach-Object {
$CurrentKey = (Get-ItemProperty -Path $_.PsPath)
If ($CurrentKey -match $WhatToLookFor){
$CurrentKey|Remove-Item -Force
}
}

Stop-Service -Name "AteraAgent" -Force
Start-Sleep -Seconds 10

$Processes = "TicketingTray.exe", "AteraAgent.exe", "AgentPackageMonitoring.exe", "AgentPackageInformation.exe", "AgentPackageRunCommand.exe", "AgentPackageRunCommandInteractive.exe", "AgentPackageEventViewer.exe", "AgentPackageSTRemote.exe", "AgentPackageInternalPoller.exe", "AgentPackageWindowsUpdate.exe", "AgentPackageFileExplorer.exe" , "AgentPackageHeartbeat.exe", "AgentPackageNetworkDiscovery.exe", "AgentPackageProgramManagement.exe", "AgentPackageRegistryExplorer.exe", "AgentPackageServicesCommands.exe", "AgentPackageSystemTools.exe", "AgentPackageTaskManagement.exe", "AgentPackageTaskScheduler.exe", "AgentPackageUpgradeAgent.exe", "AgentPackageWebrootManager.exe", "TicketNotifications.exe ";
$KillAllProcesses = foreach ($Process in $Processes){
Stop-Process -Name $process -Force 
}
Remove-Service -Name "AteraAgent"
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "AlphaHelpdeskAgent" -Force
Remove-Item -Path "HKCU:\Software\ATERA Networks\*" -Recurse -Force
Remove-Item -Path "HKLM:\Software\ATERA Networks\*" -Recurse -Force
Remove-Item -Path "C:\Program Files\ATERA Networks" -Recurse -Force
Remove-Item -Path "C:\Program Files (x86)\ATERA Networks" -Recurse -Force
Remove-Item -Path ($Env:Tmp, "eo.webbrowser.cache.19.0.69.0.1.1" -join "\") -Recurse -Force
Remove-Item -Path ($ENV:Tmp, "TicketingAgentPackage" -join "\")-Recurse -Force
Remove-Item -Path ($ENV:Tmp, "TrayIconCaching" -join "\") -Recurse -Force
Remove-Item -Path "C:\Windows\Temp\AteraUpgradeAgentPackage" -Recurse -Force