[CmdletBinding()]
param(
    $OutputPath = $env:OUTPUT_PATH ?? '/output',
    $ContainerLabel = $env:CONTAINER_LABEL ?? 'winterminal=1',
    $FragmentWinPath = $env:FRAGMENT_WIN_PATH ?? '/output'
)

$iconPath = $FragmentWinPath + '/docker.bmp'
$profilePath = Join-Path $OutputPath 'docker.json'

New-Item -Type Directory $OutputPath -Force | Out-Null
Copy-Item $PSScriptRoot/../assets/docker.bmp $OutputPath -Force

Import-Module $PSScriptRoot/../src/DevOpsifyMe.ContainersTerminal

while($true) {
    Set-WindowsTerminalProfile -ContainerLabel $ContainerLabel -ProfilePath $profilePath -IconPath $iconPath
    Remove-OldContainers -ContainerLabel $ContainerLabel

    Start-Sleep -Seconds 10
}