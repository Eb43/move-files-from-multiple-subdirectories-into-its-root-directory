$source = Get-Location
Get-ChildItem $source -Recurse | Where-Object {!$_.PSIsContainer} | ForEach-Object {
    $destination = Join-Path $source $_.Name
    if (!(Test-Path -Path $destination -PathType Leaf)) {
        Move-Item $_.FullName $destination
        Write-Output "Moved $($_.FullName) to $destination"
    } else {
        Write-Output "File $($_.Name) already exists in the destination folder"
    }
}