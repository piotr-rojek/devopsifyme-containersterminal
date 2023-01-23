function Set-WindowsTerminalProfile {
    param(
        $ProfilePath,
        $IconPath,
        $ContainerLabel  
    )

    $profiles = @();
    $profiles += @(Get-ContainerProfiles -IconPath $IconPath -ContainerLabel $ContainerLabel)
    $profiles += @(Get-ImageProfiles -IconPath $IconPath -ContainerLabel $ContainerLabel)
    $profiles += @(Get-KnownImagesProfiles -IconPath $IconPath -ContainerLabel $ContainerLabel)

    $contents = @{
        profiles = $profiles
    }

    $contents | ConvertTo-Json -Depth 99 > $ProfilePath
}