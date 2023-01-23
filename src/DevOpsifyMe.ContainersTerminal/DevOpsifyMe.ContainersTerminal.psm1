Get-ChildItem $PSScriptRoot/private/*.ps1 | % { 
    . $_.FullName 
}

Get-ChildItem $PSScriptRoot/public/*.ps1 | % { 
    . $_.FullName 
}

