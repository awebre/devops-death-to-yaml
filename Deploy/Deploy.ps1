param (
    [string]$package
)

Write-Output "Logging in to Azure via service principal..."
az login `
    --service-principal `
    --username $Env:AZ_CLIENT_ID `
    --password $Env:AZ_CLIENT_SECRET `
    --tenant $Env:AZ_TENANT_ID 
Write-Output "Successfully logged in!"

Write-Output "Setting azure subscription..."
az account set --subscription $Env:AZ_SUBSCRIPTION_ID
Write-Output "Done setting azure subscription!"

Write-Output "Creating Web App: $Env:WEB_APP_NAME..."
az webapp create --name $Env:WEB_APP_NAME --plan $Env:APP_SERVICE_PLAN --resource-group $Env:RESOURCE_GROUP --runtime "DOTNETCORE:6.0"
Write-Output "Done creating Web App!"

Write-Output "Publishing $package to Web App: $Env:WEB_APP_NAME..."
# the following is a hack that is necessary because the zip deploy is deploying to a subfolder (for... reasons?)
$targetDir = Split-Path $package -LeafBase
az webapp config set --resource-group $Env:RESOURCE_GROUP --name $Env:WEB_APP_NAME --startup-file "dotnet /home/site/wwwroot/$targetDir/DeathToYaml.Api.dll"
az webapp deployment source config-zip --name $Env:WEB_APP_NAME --resource-group $Env:RESOURCE_GROUP --src $package
Write-Output "Done publishing $package to Web App!"