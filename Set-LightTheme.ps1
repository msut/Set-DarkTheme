function Set-LightTheme {
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 1
}

function Add-EnableLightThemeTask {
    param (
        [Parameter(Mandatory=$true)]    
        [string] $taskTime
    )
    $taskName = "Set-LightTheme"
    $description = "Change Windows system and app settings to light theme."
    $taskWorkingDirectory = Get-Location
    $taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' `
        -Argument '-nologo -File Set-LightTheme.ps1' `
        -WorkingDirectory $taskWorkingDirectory
    $taskTrigger = New-ScheduledTaskTrigger -Daily -At $taskTime

    Register-ScheduledTask -TaskName $taskName `
        -Action $taskAction `
        -Trigger $taskTrigger `
        -Description $description
}

Set-LightTheme