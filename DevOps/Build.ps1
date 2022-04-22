param ($deploy)

dotnet build
dotnet test

# If we are set for deployment and the previous have succeeded
if($deploy -eq $true -and $?) {
    Write-Host "We should deploy now!"
}