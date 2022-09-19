# Solid Egress Filter - Terraform Modules

Terraform modules that allow for easy [egress filtering](https://en.wikipedia.org/wiki/Egress_filtering) in Cloud. It was loosely inspired by [this article ](https://aws.amazon.com/blogs/security/how-to-add-dns-filtering-to-your-nat-instance-with-squid/) on the AWS Security Blog.

It's especially useful for systems that value data security. Using egress filtering handles a vast array of attack vectors, like Reverse Shells.

# :warning: Pre-Release warning :warning:
This codebase is currently under early-stage developemnt. It is still not tested, contains hardcoded values and only works for special use-cases.

If you need this module show us love by leaving a star, and consider [contributing](#contribution).

## Table of Contents

- [How it works](#how-it-works)
- [Usage](#usage)
- [Supported providers](#supported-providers)
- [Contribution](#contribution)
- [License](#licence)

## How it works

The module re-configures the entire VPC routing to redirect all egress traffic to a [MITM Proxy](https://mitmproxy.org/) in Transparent mode.
This allows us to avoid client-side configuration and ensures all egress traffic is compliant by default.

The Proxy acts as a NAT gateway for the VPC and gets exclusive rights to access the Internet via network tags and firewall rules.

TODO: abstract architecture diagram

## Usage

GCP example:

```tf
module "egress_filter" {
  source   = "TODO"
  variable = "TODO
}
```

## Supported Cloud Providers

- [Google Cloud Platform](https://github.com/Solid-Potential/solid-egress-filter/blob/main/gcp) (:construction: Under development)
- AWS (:hourglass_flowing_sand: planned)
- Azure (:hourglass_flowing_sand: planned)

## Code style, code analysis and documentation
Code style guide can be found [here](https://github.com/Solid-Potential/solid-egress-filter/blob/main/TERRAFORM_STYLE_GUIDE.md)

For static code analysis we are using [tfsec](https://github.com/aquasecurity/tfsec) - tool for static analysis of terraform code to spot potential misconfigurations.

Module documentation is generated using [tfdoc](https://github.com/maur1th/tfdoc). Be sure to follow our code convention!

## Contribution

We appreciate feedback and contribution to this template! Before you get started, please see the following:

- [General contribution guidelines](https://github.com/Solid-Potential/solid-egress-filter/blob/main/CONTRIBUTING.md)
- [Code of Conduct](https://github.com/Solid-Potential/solid-egress-filter/blob/main/CODE-OF-CONDUCT.md)

## Licence

This repo is covered under the [GNU General Public License](https://github.com/Solid-Potential/solid-egress-filter/blob/main/LICENSE)
