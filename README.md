# Solid Egress Filter - Terraform Modules

Terraform modules that allow for easy [egress filtering](https://en.wikipedia.org/wiki/Egress_filtering) in Cloud. 

It's especially useful for systems that value data security. Using egress filtering handles a vast array of attack vectors, like Reverse Shells.

## Usage

GCP example:

```tf
module "egress_filter" {
  source   = "TODO"
  variable = "TODO
}
```

## How it works

The module re-configures the entire VPC routing to redirect all egress traffic to a [MITM Proxy](https://mitmproxy.org/) in Transparent mode.
This allows us to avoid client-side configuration and ensures all egress traffic is compliant by default.

The Proxy acts as a NAT gateway for the VPC and gets exclusive rights to access the Internet via network tags and firewall rules.

TODO: abstract architecture diagram

## Supported providers

* Google Cloud Platform (planned) 
* AWS (planned)
* Azure (planned)
