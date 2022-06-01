# Extra uitleg: AKS files

De bestanden die in het mapje [`aks-files`](https://github.com/WoutBeyens/CICDaas-store/tree/main/Files/Aks-files) zitten kan je naar je lokale machine clonen en open deze bestanden vervolgens in Visual Studio Code.

Dit mapje bevat volgende bestanden:

1. **Variables.tf** - Hier definieren we de variabelen die gebruikt worden in de main.tf
2. **terraform.tfvars**- Hier declareren we de waarden voor de variabelen
3. **providers.tf** - Hier declareren we de provider met hun versie
4. **main.tf** - Dit is de main configuration file met alle resources die aangemaakt moeten worden.
5. **output.tf** - Exporteert data naar de output file

## Uitleg per bestand

Per bestand wordt er in commentaar uitleg gegeven over onderstaande code.

* Het bestand `providers.tf`:

> In deze file hoef je niets te wijzigen

```terraform
# Configureer de Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# In de required_providers block kunnen we de source & version meegeven; let op dat je dezelfde version neemt. Nieuwere versions kunnen mogelijks problemen veroorzaken.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.39.0"
    }
  }
}
```

* Het bestand `variabels.tf`:

> In deze file hoef je niets te wijzigen

```terraform
#Hier declareren we de variabelen die we gebruiken in de main.tf. De variabelen spreken voor zich door de goede naamkeuze en de beschrijving.
variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
variable "acr_name" {
  type        = string
  description = "ACR name"
}
```

* Aanmaken van de `terraform.tfvars`:

> De waarde voor de variabele ***acr_name***, wat dus de naam van de Azure Container Registry is, zal je zelf moeten aanpassen naar een zelfgekozen naam aangezien dat deze naam **uniek** moet zijn. **M.a.w. vervang je "XXXXXXX" naar iets anders bijvoorbeeld "Myacr948753218"**.

```terraform
# Hier geven we een waarde mee voor de variabelen die gedeclareerd werden in variables.tf.  
resource_group_name = "aks_tf_rg"
location            = "WestEurope"
cluster_name        = "devops-cluster-aks"
kubernetes_version  = "1.21.7"
system_node_count   = 2
acr_name            = "XXXXXXX"
```

* Aanmaken van de `main.tf`:

> Bij de resource *azure_resource_group* wijzig je de naam van de ***owner*** en vul je je eigen naam in. M.a.w. verander je de "XXXX" bij owner naar je eigen naam. 

```terraform
# Dit is de main config file die alle resources bevat die aangemaakt moeten worden.

# Wijzig owner naar je naam
resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    owner ="XXXX"
  }
}

# Hier hoef je niets te wijzigen
resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}

#Hier hoef je niets te wijzigen
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks-rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

# Hier hoef je niets te wijzigen
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet" 
  }
}
```

* Aanmaken van de `output.tf` file.

> In deze file hoef je niets te wijzigen

```terraform
output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

resource "local_file" "kubeconfig" {
  depends_on   = [azurerm_kubernetes_cluster.aks]
  filename     = "kubeconfig"
  content      = azurerm_kubernetes_cluster.aks.kube_config_raw
}
```
