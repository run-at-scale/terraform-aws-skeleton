# Testing

Testing provides a way to instantiate and verify Terraform modules in a safe, isolated,
and prod-like manner. This is a critical component to achieving and proving adherance
to policy and requirmenets of any client projects.

## Tools

### kitchen-terraform (+ test-kitchen)

We develop an open-source test-kitchen (KitchenCI) plugin for testing Terraform code
called [`kitchen-terraform`](https://github.com/newcontext-oss/kitchen-terraform).
It gives test kitchen the facilities to use Terraform as a driver to configure, create,
test, and destroy resources in an automated workflow.

### InSpec

[InSpec](https://www.inspec.io/) is the high-level testing library that supercedes
and builds upon the ideas of previous infrastructure test libraries - most notably
[Serverspec](http://serverspec.org/). It aims to test the state of a host or container
against your assertions. This is most effective when trying to run service foo on
a host/container and verify that it is configured properly and works as expected.

### awspec

[awspec](https://github.com/k1LoW/awspec) is another high-level testing library based
on RSpec which aims to test the creation, details, and relationships between resources
in AWS. Some modules lend better to this test library as a module may not be built
to instantiate a service that runs on VMs or within containers that we control directly.
Though Terraform is a declative language and we have decent guarantees that resources
we declare will be created, it's helpful to codify the details of how those resources
look and behave once instantiated as a unit. The `awspec` gem and its conterpart gem
[kitchen-verifier-awspec](https://github.com/neillturner/kitchen-verifier-awspec)
should be included in the `Gemfile` and used in these situations.

## Techniques

### Sharing tests between suites

There are situations where more than one test suite should be defined but the underlying
tests for those suites are essentially the same. A practical example of this are
test-fixtures that cover the govcloud region as well as standard AWS commercial regions.
Within govcloud, certain AWS services like Route53 are absent and test resources should
toggle this accordingly. In these cases, directories containing tests for suites needing
to share tests can use symlinks within their directories.

### Integration testing

What we often do with the test tools above would consistute unit testing in software.
However, consider that some modules might be both reusable in multiple contexts but
also a dependency for other systems. For example, Consul can be used for DNS but also
serve as a key value store more generally for something like Vault. In these cases,
a developer shouldn't hesitate to create a set of test fixtures for integration test
purposes. That is, a test fixture and set of tests that instaniates more than one
module to ensure they interoperate as expected. This integration suite should be created
on the specific rather than generic module where the dependency arrow points away.
In the example case of Vault and Consul, Vault should contain that integration suite.

### Testing locally through a bastion/jump host

Currently test kitchen does not support using a bastion/jump host - something we
always deploy to maintain tighter control over `ssh` access. In order to run tests
on Terraform-created hosts behind a bastion use [sshuttle](https://github.com/apenwarr/sshuttle)
between the `converge` and `verify` test kitchen commands.

```bash
bundle exec kitchen converge
...
ssh-add test/fixtures/tf_aws_example/keys/example_id_rsa
sshuttle --dns -r <user>@<bastion_public_ip> --disable-ipv6 <your_test_vpcs_ip_block>/<some_mask>
bundle exec kitchen verify && bundle exec kitchen destroy
```
