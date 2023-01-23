function Get-ContainerProfiles {
    param(
        $ContainerLabel,
        $IconPath,
        $Enabled = $env:CONTAINER_PROFILES_ENABLED ?? $true,
        $Hidden = $env:CONTAINER_PROFILES_HIDDEN ?? $true,
        $Filter = $env:CONTAINER_PROFILES_FILTER ?? $null
    )

    if(-not $Enabled) 
    {
        return @()
    }

    $filterArgs = $Filter ? ($Filter -split ';') : @() | % { 
        "--filter"
        "$_"
    }

    $containers = docker container ls --format "{{json . }}" @filterArgs | ConvertFrom-Json
    foreach($container in $containers)
    {
        $inspect = docker container inspect $container.ID | ConvertFrom-Json
        if($inspect[0].Platform -ne 'linux') 
        {
            Write-Verbose "Unsupported platform $($inspect[0].Platform) for $($inspect[0].Name)"
            continue;
        }

        @{
            name = "Container $($container.Names ?? $container.ID) - $($container.Image)"
            commandline = "docker exec -it $($container.ID) sh"
            closeOnExit = "graceful"
            icon = $IconPath
            hidden = $Hidden ? $true : $false
        }
    }
}