param (
    [string]$packagePath
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

Write-Output "Creating App Service Plan: ${$Env:APP_SERVICE_PLAN}"
az appservice plan create --name $Env:APP_SERVICE_PLAN --resource-group $Env:RESOURCE_GROUP
Write-Output "Done creating App Service Plan!"

Write-Output "Creating Web App: ${$Env:WEB_APP_NAME}"
az webapp create --name $Env:WEB_APP_NAME --plan $Env:APP_SERVICE_PLAN --resource-group $Env:RESOURCE_GROUP
Write-Output "Done creating Web Ap!"

Write-Output "Publishign package to Web App: ${$Env:WEB_APP_NAME}"
az webapp deployment source config-zip --name $Env:WEB_APP_NAME --resource-group $Env:RESOURCE_GROUP --src $packagePath
Write-Output "Done publishing package to Web App!"