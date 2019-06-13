#!/bin/bash

# Create a resource group.
az group create --name ${NAME} --location ${LOCATION}

# Create a virtual network.
az network vnet create --resource-group ${NAME} --name ${NAME} --subnet-name ${NAME} --address-prefix ${CIDR}

# Create a public IP address.
az network public-ip create --resource-group ${NAME} --name ${NAME}
az network public-ip update -g ${NAME} -n ${NAME} --allocation-method static
az network dns record-set a create --name ${NAME} --resource-group dns --zone-name azure.dashaun.cloud --target-resource /subscriptions/${SUBSCRIPTION_ID}/resourceGroups/jumpbox/providers/Microsoft.Network/publicIPAddresses/${NAME}

# Create a network security group.
az network nsg create --resource-group ${NAME} --name ${NAME}

# Create a virtual network card and associate with public IP address and NSG.
az network nic create \
  --resource-group ${NAME} \
  --name ${NAME} \
  --vnet-name ${NAME} \
  --subnet ${NAME} \
  --network-security-group ${NAME} \
  --public-ip-address ${NAME}

# Create a new virtual machine, this creates SSH keys if not present.
az vm create --resource-group ${NAME} --name ${NAME} --nics ${NAME} --image UbuntuLTS --generate-ssh-keys --size ${VM_SIZE} --location ${LOCATION} --ssh-key-value @${PUB_KEY_PATH}

# Open port 22 to allow SSh traffic to host.
az vm open-port --port 22 --resource-group ${NAME} --name ${NAME}
