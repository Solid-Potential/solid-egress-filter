# Terraform Style Guide

**Table of Contents**

- [Introduction](#introduction)
- [General](#general)
  - [Resource Block Alignment](#resource-block-alignment)
  - [String Values](#string-values)
  - [Spacing](#spacing)
  - [Comments](#comments)
  - [Organizing Block labels, Variables and Outputs](#organizing-block-labels-variables-and-outputs)
- [Naming Conventions](#naming-conventions)
  - [File Names](#file-names)
  - [Parameter, Meta-parameter and Variable Naming](#parameter-meta-parameter-and-variable-naming)
  - [Resource Naming](#resource-naming)

## Introduction

This document provides coding conventions used in all Solid Potential repositories for Terraform's HashiCorp Configuration Language (HCL). Code convetion are introduced to adhere a style guide to ensure readable and high quality code.

## General

### Resource Block Alignment

Parameter definitions in a resource block should be aligned. The `terraform fmt` command can do this for you.

### String Values

- Strings are in double-quotes.

### Spacing

Use 2 spaces when defining resources except when defining inline policies or other inline resources.

### Comments

When commenting use a hash `#` and a space in front of the comment. We prefer `#` over `//` or `/**/` for line comments. For delimiting section header comment blocks with `# ----- <SECTION_NAME> -----`.

### Organizing Block labels, Variables and Outputs

The label for blocks should be in snake case and lowercase. i.e.: `example_instance` , not `ExampleInstance` or `example-instance`

Variables and outputs should be created based on following rules:
- Name - similarly to blocks both variables and outputs should be in snake case and lowercase. Additinally:
   - Names should reflect the attribute or argument they reference in its suffix i.e.: `foo_bar_name` or `foo_bar_id` but not `foo_bar`
   - Use plural form in names of variables that expect a collection of items i.e.: `foo_bars` for multiple items or `foo_bar` for single item
- Description - each variable or output shoul contain meaningful description
- Type - each variable or output should contain defined type even if it is of type `string` (default)
- Defaults (Optional) - if a module should configure anything using miminal configuration use defaults in variables rather than hardcode values used in resources

The `variables.tf` file should be broken down into three sections with each section arranged alphabetically. Starting at the top of the file:

1. Variables that have no defaults defined
2. Variables that contain defaults
3. All locals blocks

### Conditionals
Use `()` to break up **complex** conditionals across multiple lines for better readability. i.e.:

```
locals {
  is_prod = var.environment == "prod" ? true : false

  instance_name = (
    var.instance_name != "" 
    ? var.instance_name 
    : "vm-${var.image_name}"
  )
}
```

## Naming Conventions

### File Names

Create a separate resource file for each type resource. Similar or bundled resources should be defined in the same file and named accordingly.

### Parameter, Meta-parameter and Variable Naming

__Only use an underscore (`_`) when naming Terraform resources like TYPE/NAME parameters and variables.__

```
resource "google_compute_instance" "vm_instance" {
    ...
}
```
 
### Resource Naming

__Only use a hyphen (`-`) when naming the component being created.__

```
resource "google_compute_instance" "vm_instance" {
  name = "test-vm"  
  ...
}
```

__A resource's NAME should be the same as the TYPE minus the provider.__

```
  resource "google_storage_bucket" "storage_bucket" {
    ...
  }
```

If there are multiple resources of the same TYPE defined, add a minimalistic identifier to differentiate between the two resources. A blank line should sperate resource definitions contained in the same file.

```
# Create Data Bucket
  resource "google_storage_bucket" "data_storage_bucket" {
    ...
  }

# Create Images Bucket
  resource "google_storage_bucket" "images_storage_bucket" {
    ...
  }
```
