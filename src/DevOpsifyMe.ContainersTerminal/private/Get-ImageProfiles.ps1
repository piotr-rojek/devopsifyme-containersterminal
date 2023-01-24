function Get-ImageProfiles {
    param(
        $ContainerLabel,
        $IconPath,
        $Enabled = $env:IMAGE_PROFILES_ENABLED ?? $true,
        $Hidden = $env:IMAGE_PROFILES_HIDDEN ?? $true,
        $Filter = $env:IMAGE_PROFILES_FILTER
    )

    if(-not $Enabled) 
    {
        return @()
    }

    $filterArgs = $Filter ? ($Filter -split ';') : @() | % { 
        "--filter"
        "$_"
    }

    $images = docker image ls --format "{{json . }}" @filterArgs | ConvertFrom-Json
    foreach($image in $images)
    {
        if('<none>' -eq $image.Repository -or '<none>' -eq $image.Tag) 
        {   
            Write-Verbose "Skipping image $($image.ID) because it has no repository and/or tags"
            continue;
        }

        if($KnownImages -contains "$($image.Repository):$($image.Tag)")
        {
            continue;
        }

        @{
            name = "Image $($image.Repository):$($image.Tag)"
            commandline = "docker run -it --rm -v /mnt/c:/mnt/c -l $ContainerLabel $($image.ID) sh"
            closeOnExit = "graceful"
            icon = $IconPath
            hidden = $Hidden ? $true : $false
        }
    }
}