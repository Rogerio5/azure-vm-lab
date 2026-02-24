# templates/create_resources.ps1
param(
  [string]$RG = "devops-na-infra",
  [string]$LOCATION = "eastus",
  [string]$VM_NAME = "vm-devops-na-infra",
  [string]$ADMIN_USER = "azureuser"
)

Write-Host "Verificando Azure CLI..."
if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
  Write-Error "Azure CLI não encontrado. Instale ou use Cloud Shell."
  exit 1
}

az login

Write-Host "Criando resource group $RG em $LOCATION..."
az group create --name $RG --location $LOCATION

Write-Host "Criando NSG..."
az network nsg create -g $RG -n "nsg-$RG" --location $LOCATION

Write-Host "Criando VM (exemplo)..."
az vm create -g $RG -n $VM_NAME --image UbuntuLTS --size Standard_B1s --admin-username $ADMIN_USER --generate-ssh-keys --nsg "nsg-$RG" --public-ip-sku Standard --output json

Write-Host "Recursos criados. Use scripts/collect_evidence.sh para coletar evidências."
