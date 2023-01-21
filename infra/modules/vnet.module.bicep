param name string
param location string = resourceGroup().location
param tags object = {}
param addressPrefix string
param includeBastion bool = true

param appSnet object
param infraSnet object
param bastionSnet object
param agwSnet object

var appSnetConfig = {
  name: 'app-snet'
  properties: appSnet
}

var infraSnetConfig = {
  name: 'infra-snet'
  properties: infraSnet
}

var bastionSnetConfig = {
  name: 'AzureBastionSubnet'
  properties: bastionSnet
}

var agwSnetConfig = {
  name: 'agw-snet'
  properties: agwSnet
}

var fixedSubnets = [
  appSnetConfig
  infraSnetConfig
  agwSnetConfig
]

var allSubnets = includeBastion ? union(fixedSubnets, [
  bastionSnetConfig
]) : fixedSubnets

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: allSubnets
  }
  tags: tags
}

output vnetId string = vnet.id
output appSnetId string = vnet.properties.subnets[0].id
output infraSnetId string = vnet.properties.subnets[1].id
output agwSnetId string = vnet.properties.subnets[2].id
output bastionSnetId string = includeBastion ? vnet.properties.subnets[3].id : ''
