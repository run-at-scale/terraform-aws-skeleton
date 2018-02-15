# Modules

Modules contain a logically coupled set of Terraform resources that aid in abstracting
away the implementation details of how the resources are created and fit together.
Properly built, a module provides stability, abstraction (small interface), and proof
of correctness through tests.

This repo serves as a living example of a well-crafted module and expands on the
Hashicorp basic [module standards](https://www.terraform.io/docs/modules/create.html#standard-module-structure).

## Module structure

All files ending in `.tf` in the repo root comprise the Terraform code for a module
and can essentially be thought of as the same file. Given that we have the ability
to spread resources, outputs, variables, data sources, and locals across several
`.tf` files, we should, especially when files start to become large.

One way to organize a module is to separate out the primary resources into `main.tf`,
data sources into `data.tf`, outputs into `outputs.tf`, etc. This is a simple separation that gives
other developers a good chance at knowing where a certain element can be found.
As an alternative, it might make more sense to separate elements into service-centric
files. For instance, all IAM related resources and data sources might land in a
file called `iam.tf`.

Unfortunately, Terraform module standards leave us comingling repo metadata and ancillary
code with Terraform templates at the repo root. The result is a somewhat cluttered
root where the core of the module exists. The value of these files outweighs this
heigine drawback.

## Module size

A module should be as small and focused as possible while still providing utility
as a collection of resources. In other words, if a set of two or more resources are
commonly deployed together to realize a shared purpose or larger goal together, they
should be coupled within a module.

Related to this, a module should ideally follow the Unix philosophy of doing one thing
well. In practice, this often means a module centers around one core resource, attempting
to create it and it's related resources with just enough flexibility for the common
use cases. It follows that a module should avoid producing *n* core resources in favor
of the upstream caller assuming responsibility of making multiple calls to the module.

Examples of appropriate resource coupling and module right-sizing:

* An autoscaling group and launch configuation are useless without eachother and are almost always best managed together in a module.
* Network resources often only make sense when created together. There is little use for a VPC without subnets, route tables, and route table associations? Practically none.
* A service or service component like Consul, Vault, an ELK stack are likely best suited for module.

Note: A blunt but somewhat effective heuristic for module size could be the raw number
of resources created. In this author's admittedly overly-opinionated approach, a
module that creates more than 50 resources smells of doing too much.

## Module nesting

Though tempting, nesting modules should be avoid if possible. Deeply nested dependencies
are more difficult to update, harder to reason about, and result in much larger, more
fragile, and harder to test modules. In almost all cases, a developer should consider
a flatter, more layered approach to overlapping module functionality. In turn, this
approach supports our goals of smallness and reusability.

Embedded submodules within modules (e.g. `submodule_foo/main.tf`) should also be
avoided as it creates a burden to test, loses the ability to version independently,
and cannot be shared through standard means (double slash `//` is possible but not
cool).

## Versioning

Versioning makes good on a module's promise of stability, which is essential for
any system having independently developed depenencies. In practice, we adhere to
semantic versioning as our guide.

This example/skeleton follows semantic versioning with the following domain specific
rules for Terraform modules:

* Input/output changes that break API == major
* Changes that could cause an outage == major
* Input/output additions (that have defaults matching previous functionality) == minor
* Fixes that do not match any of the above == patch
* The version file should always have a corresponding git tag
* Repos should contain a file called `version` that only contains the version number + newline

## Promotion

Without the use of Terraform enterprise, the use of git tags is currently the best way
to pin and promote versions of Terraform modules. This Terraform module tags each change
to master with what version resides in the file 'version'.
This pinning will be the version released, without a “v” prefix. Consumption of this module can be done
similar to: `source = "git::git@github.com:newcontext/tf_aws_example_skeleton.git?ref=<your_tag>"`

## Ownership/guard rails

The master branch of any module/repo should be protected and “Require pull request
reviews before merging.” Pull requests should also have a passing latest commit from CI server prior to merging. IAM resources are recommended to be split out from the application/service Terraform module
to allow privileged teams to push out IAM resources without coupling application/service deployments.
