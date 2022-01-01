function Set-DarkTheme {
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0
}

function Add-EnableDarkThemeTask  {
    param (
        [Parameter(Mandatory=$true)]    
        [string] $taskTime
    )
    $taskName = "Set-DarkTheme"
    $description = "Change Windows system and app settings to dark theme."
    $taskWorkingDirectory = Get-Location
    $taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' `
        -Argument '-nologo -File Set-DarkTheme.ps1' `
        -WorkingDirectory $taskWorkingDirectory
    $taskTrigger = New-ScheduledTaskTrigger -Daily -At $taskTime

    Register-ScheduledTask -TaskName $taskName `
        -Action $taskAction `
        -Trigger $taskTrigger `
        -Description $description
}

Set-DarkTheme