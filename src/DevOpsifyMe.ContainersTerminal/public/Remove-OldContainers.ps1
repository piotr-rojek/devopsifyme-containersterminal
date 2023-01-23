function Remove-OldContainers() 
{
    param(
        $ContainerLabel
    )

    docker container prune --filter "label=$ContainerLabel" --force

    $containers = docker container ls --filter "label=$ContainerLabel" --filter "status=running" --format "{{json . }}" | ConvertFrom-Json
    $containers | ForEach-Object {
        $container = $_

        $createdAtDateTime = $container.CreatedAt.Substring(0,19)
        $createdAt = Get-Date $createdAtDateTime
        $containerAge = (Get-Date) - $createdAt

        if($containerAge.TotalHours -lt 3.0)
        {
            Write-Verbose "Skipping container $($container.Name) with ID $($container.ID) age $containerAge"
            continue;
        }

        Write-Host "Removing long running container $($container.Name) with ID $($container.ID) age $containerAge"
        docker container rm --force $container.ID
    }
}