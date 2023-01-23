$imageTag = "devopsifyme/containersterminal:local"
$containerName = "test"

$fragmentPath = "Users/$($env:USERNAME)/AppData/Local/Microsoft/Windows Terminal/Fragments/DevOpsifyMe.ContainersTerminal"
$winPath = "c:/$fragmentPath"
$linuxPath = "/mnt/c/$fragmentPath"

docker build --tag $imageTag .
docker rm $containerName --force
docker run `
    -it `
    --name $containerName `
    -e FRAGMENT_WIN_PATH=$winPath `
    -e KNOWN_IMAGES='debian' `
    -v /run/docker.sock:/var/run/docker.sock `
    -v "$($linuxPath):/output" `
    $imageTag