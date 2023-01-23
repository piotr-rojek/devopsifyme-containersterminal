function Get-KnownImagesProfiles {
    param(
        $ContainerLabel,
        $IconPath,
        $Enabled = $env:KNOWN_IMAGE_PROFILES_ENABLED ?? $true,
        $Hidden = $env:KNOWN_IMAGE_PROFILES_HIDDEN ?? $false,
        $KnownImages = $env:KNOWN_IMAGES ? ($env:KNOWN_IMAGES -split ';') : @('alpine', 'ubuntu', 'python', 'openjdk', 'golang', 'centos', 'debian')
    )

    if(-not $Enabled) 
    {
        return @()
    }

    foreach($image in $KnownImages)
    {
        @{
            name = "Known Image $image"
            commandline = "docker run -it -v /mnt/c:/mnt/c -l $ContainerLabel $image sh"
            closeOnExit = "graceful"
            icon = $IconPath
            hidden = $Hidden ? $true : $false
        }
    }
}