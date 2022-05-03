param (
    [string]$publishDir
)

dotnet build --configuration Release
dotnet test

# If we are set for deployment and the previous commands have succeeded
if ($publishDir -and $?) {
    Write-Output "Creating package: $publishDir.zip...."

    dotnet publish ./DeathToYaml.Api/DeathToYaml.Api.csproj --configuration Release --output $publishDir
    Compress-Archive $publishDir "$publishDir.zip" -Force
    
    Write-Output "Successfully packaged $publishDir.zip"
}