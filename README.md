# CICDaas-store

Deze repository zal CICD as a service aanbieden aan de klant. Zo kan de klant zelfstandig aan de slag gaan om CICD op te zetten via een simpele guide die door de klant gevolgd kan worden. Zo is het mogelijk dat de klant bijvoorbeeld een bepaalde programmeertaal in een placeholder kan invullen en zelf de code aanpassen aan de hand van een eenvoudige guide met code snipets zodat de modulaire pipeline ook zal werken voor een applicatie met een andere soort programmeertaal.

## 1. Het opzetten van een Kubernetes cluster in Azure met Terraform

In dit onderdeel zal er getoond worden hoe je een Kubernetes cluster op kan zetten op een platform naar keuze. In deze guide wordt er voor Azure gekozen en zal er een Azure Kubernetes Service (AKS) opgezet worden.

We kunnen de AKS cluster op verschillende manieren opzetten (via de Azure portal, Azure CLI of Terraform). Hier gaan we de cluster opzetten via dat laatste, Terraform.

![afbeelding aks](Images/opstelling_terraform.png)

**Enkele vereisten:**

- Terraform moet geïnstalleerd zijn op de machine
- Een Azure account met een geldige subscriptie
- Kubectl moet geïnstalleerd zijn op de machine
- Azure CLI moet geïnstalleerd zijn op de machine

**Effectieve AKS deployment**

Voor de effectieve AKS deployment volg je de [`AKS-documentatie.md`](Files/extra-uitleg/AKS-documentatie.md) file.

## 2. Modulaire pipelines configureren

### 2.1 CICD voor maar één applicatie te deployen op AKS

Indien je maar één applicatie wilt deployen via Github Actions op je AKS cluster dan verwijs ik je naar [`CICD-een-app.md`](Files/extra-uitleg/CICD-een-app.md), want dan zijn volgende complexere stappen niet nodig.

### 2.2 CICD voor meerdere applicaties te deployen op AKS

Als je meer dan één applicatie wilt deployen via Github Actions op je AKS cluster dan verwijs ik je naar [`CICD-meerdere-apps.md`](Files/extra-uitleg/CICD-meerdere-apps.md).

## 3. DEV/ACC/PRO releases & Approvals toevoegen aan de pipeline

### 3.1 DEV/ACC/PRO releases

[TO DO]

### 3.2 Approvals 

[TO DO]

## 4. Vulverability scans & Testing toevoegen

### 4.1 Vulnerability scans

[TO DO]

### 4.2 Testing

[TO DO]
