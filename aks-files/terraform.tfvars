# Hier declareren we de waarden voor de gedefinieerde variabelen in variables.tf
resource_group_name = "aks_tf_rg"
location            = "WestEurope"
cluster_name        = "devops-cluster-aks"
kubernetes_version  = "1.21.7"
system_node_count   = 2
acr_name            = "myacr4568975"