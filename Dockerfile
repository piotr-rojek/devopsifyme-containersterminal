FROM docker as docker
FROM mcr.microsoft.com/powershell

COPY --from=docker /usr/local/bin/docker  /usr/local/bin/docker
COPY ./ /work/

WORKDIR /work
CMD [ "pwsh", "-File", "/work/assets/entrypoint.ps1" ]
