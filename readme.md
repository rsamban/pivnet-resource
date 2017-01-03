# Pivnet Resource
Downloads products from Pivotal Network [https://network.pivotal.io](https://network.pivotal.io)
There is already resource to download products from Pivotal Network. Please check [https://github.com/pivotal-cf/pivnet-resource](https://github.com/pivotal-cf/pivnet-resource) for more details. This resource differs in following way.  
1. Implemented with bash scripts  
2. Can download multiple products in one operation.  
3. You must specify exact product version that needs to be downloaded.  
## Resource Type Configuration
```
resource_types:
- name: mypivnet
  type: docker-image
  source:
    repository: rsamban/pivnet
    tag: "1.0"
    
```
## Source Configuration
To download products from Pivotal Network,  

```
resources:
- name: pcf-products
  type: mypivnet  
  source:
    iaas: {{IAAS}}
    api_token: {{PIVNET_TOKEN}} 
```
`iaas:` Required. Primarily required for stemcell downloads as stemcells are IaaS specific. Should be on of `AWS`, `Azure/Google Cloud Platform`, `vSphere`, `vCloud` or `Openstack`. Currently supports only `vSphere` and `Openstack`  
`api_token:` Required. Your pivnet api token  

Parameters for the the source:  
`product_slugs:` Required. list of product slugs. See example below for sample values.  
`product_versions:` Requied. List of product versions for products specified in `product_slugs`. The count and order of product vesions should match with list specified in `product_slugs`



## Behavior
The following job configuration will download stemcell versions `3263.13/14`, ERT version `1.8.23-build.2`, pcf rabbitmq service version `1.7.9` and pcf mysql version `1.8.0`

```
jobs:
- name: download-products
  plan:
  - aggregate:
    - get: pcf-products
      params:
        product_slugs:
        - product_slug: stemcells
        - product_slug: stemcells
        - product_slug: elastic-runtime
        - product_slug: pivotal-rabbitmq-service
        - product_slug: p-mysql
        product_versions:
        - product_version: "3263.13"
        - product_version: "3263_14"
        - product_version: "1.8.23-build.2"
        - product_version: "1.7.9"
        - product_version: "1.8.0"
        
```
