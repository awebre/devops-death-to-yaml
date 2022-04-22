param (
    [switch]$deploy,
    [string]$packageDir
)

dotnet build --configuration Release
dotnet test

# If we are set for deployment and the previous commands  have succeeded
if ($deploy -eq $true -and $?) {
    Write-Output "Publishing to $packageDir.zip...."
    dotnet publish --configuration Release --output $packageDir
    Compress-Archive $packageDir "$packageDir.zip"
    Write-Output "Successfully published to $packageDir.zip"

    ./Deploy/Deploy.ps1
}