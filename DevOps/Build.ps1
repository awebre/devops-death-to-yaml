param (
    [switch]$deploy,
    [string]$publishDir
)

dotnet build --configuration Release
dotnet test

# If we are set for deployment and the previous commands  have succeeded
if ($deploy -eq $true -and $?) {
    Write-Output "Publishing to $publishDir.zip...."
    dotnet publish ./DeathToYaml.Api/DeathToYaml.Api.csproj --configuration Release --output $publishDir
    Compress-Archive $publishDir "$publishDir.zip"
    Write-Output "Successfully published to $publishDir.zip"

    ./Deploy/Deploy.ps1 -package "$publishDir.zip"
}