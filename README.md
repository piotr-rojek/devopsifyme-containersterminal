# DevOpsify Me - Containers Terminal

Tool for adding profiles to Windows Terminal related to containers, supporting following scenarios
* attach to a shell of a running container 
* start a new shell in a container for an already download / predefined image
* automatically mount C: drive for new containers, as WSL would

Every 10 seconds configuration is refreshed and exited containers are removed. Note that you have to close session by typing 'exit', otherwise container will continue to run in detached state. Assumption is that tool will be running on a WSL instance on a Windows machine, and that Windows Terminal is already installed.

More information on [Blog](https://devopsifyme.com) and [Github](https://github.com/piotr-rojek/devopsifyme-containersterminal).

## Running

```ps
$fragmentPath = "Users/$($env:USERNAME)/AppData/Local/Microsoft/Windows Terminal/Fragments/DevOpsifyMe.ContainersTerminal"
$windowsPath = "c:/$fragmentPath"
$linuxPath = "/mnt/c/$fragmentPath"
New-Item -Type Directory $windowsPath -Force | Out-Null

docker run `
    -d --restart=always `
    --name containersterminal `
    -e FRAGMENT_WIN_PATH=$windowsPath `
    -e KNOWN_IMAGES='debian;ubuntu;golang' `
    -v /run/docker.sock:/var/run/docker.sock `
    -v "$($linuxPath):/output" `
    devopsifyme/containersterminal:latest
```

## Environmental Variables
* CONTAINER_LABEL - label used to mark containers created by this tool
* FRAGMENT_WIN_PATH - full path on Windows host where generated fragment is stored, this is needed for ICON path to be correct
* KNOWN_IMAGES - ';' separated list of images to be always present on the list
* KNOWN_IMAGE_PROFILES_ENABLED - true/false, should profiles based on known images be generated
* KNOWN_IMAGE_PROFILES_HIDDEN - true/false, should profiles based on known images be hidden
* IMAGE_PROFILES_ENABLED - true/false, should profiles based on local images be generated
* IMAGE_PROFILES_HIDDEN - true/false, should profiles based on local images be hidden
* IMAGE_PROFILES_FILTER - ';' separated list of filters used to limit shown images
* CONTAINER_PROFILES_ENABLED - true/false, should profiles based on running containers be generated
* CONTAINER_PROFILES_HIDDEN - true/false, should profiles based on running containers be hidden
* CONTAINER_PROFILES_FILTER - ';' separated list of filters used to limit shown containers

