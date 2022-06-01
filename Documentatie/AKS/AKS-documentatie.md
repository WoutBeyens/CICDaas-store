# Deployment van AKS cluster met Terraform

## 1.1 Inloggen op Azure

We moeten eerste op de Azure portal inloggen via de Azure CLI.

```bash
az login
```

Dit opent een venster in de browser waarin je kan inloggen op het gewenste Azure account.

## 1.2 Een aantal nodige bestanden

Om deze cluster te kunnen opzetten dienen er een aantal bestanden aangemaakt te worden. Deze bestanden kunnen ook gevonden worden in het mapje [`aks-files.md`](https://github.com/WoutBeyens/CICDaas-store/tree/main/Files/Aks-files).

Dit mapje bevat volgende bestanden:

1. **Variables.tf** - Hier definieren we de variabelen die gebruikt worden in de main.tf
2. **terraform.tfvars**- Hier declareren we de waarden voor de variabelen
3. **providers.tf** - Hier declareren we de provider met hun versie
4. **main.tf** - Dit is de main configuration file met alle resources die aangemaakt moeten worden.
5. **output.tf** - Exporteert data naar de output file

Voor meer uitleg omtrent deze bestanden klik je op [`Aks-files-explained.md`](Files/extra-uitleg/Aks-files-explained.md)

## 1.3 Terraform files uitvoeren

Eens de Terraform files uit [`Aks-files.md`](https://github.com/WoutBeyens/CICDaas-store/tree/main/Files/Aks-files) aangepast zijn zoals uitgelegd in [`Aks-files-explained`](Files/extra-uitleg/Aks-files-explained.md) kunnen deze bestanden uitgevoerd worden.

Open de bestanden in Visual Studio Code en doe het volgende:

1. We voeren het commando `terraform init` uit om een werkende directory dat Terraform config files bevat te initialiseren. Dit is altijd het eerste commando dat je moet uitvoeren na het schrijven van een nieuwe Terraform configuration file.
2. Het volgende commando is `terraform plan`, dit zorgt ervoor dat de Terraform config files geëvalueerd worden om de *desired state* vast te stellen van alle resources die gedeclareerd werden.

> Extra info: It uses state data to determine which real objects correspond to which declared resources, and checks the current state of each resource using the relevant infrastructure provider's API. Once it has determined the difference between the current state and the desired state, terraform plan presents a description of the changes necessary to achieve the desired state. It does not perform any actual changes to real world infrastructure objects; it only presents a plan for making changes. Plans are usually run to validate configuration changes and confirm that the resulting actions are as expected. However, terraform plan can also save its plan as a runnable artifact, which terraform apply can use to carry out those exact changes.

3. Als laatst voeren we `terraform apply` commando uit, dit commando voert een plan uit zoals terraform plan doet, maar voert vervolgens de geplande wijzigingen aan elke resource uit met behulp van de relevante API van de infrastructuurprovider. Men moet ook nog een confirmeren door `yes` te typen.

## 1.4 Storage Account aanmaken op Azure

Open de resource group in *portal.azure* en open de cloud shell (vierkant-achtig symbool bovenaan). Er wordt gevraagd om een storage account aan te maken.
1. Click op *create storage*
2. Click op *advanced settings*
3. Duidt de juiste resource group aan: "aks_tf_rg"
4. Kies een naam voor een nieuwe storage account: "storageaccountwout", hier kan je dus zelf een naam naar keuze nemen
5. Kies een naam voor een nieuwe file share: "filesharewout", ook hier kan je dus zelf een naam naar keuze nemen
6. Click op *create storage*

## 1.5 Verplaats de gegenereerde Kubeconfig file naar `~/.kube/config`

Dit doen we met het commando

```bash
mv kubeconfig ~/.kube/config
```

We kunnen nu verifiëren of de worker nodes aangemaakt zijn door het commando `kubectl get nodes` uit te voer. Nu zou je de worker nodes met health status **ready** moeten zien.

> Als alles goed is gegaan is de AKS cluster nu successvol opgezet op Azure.