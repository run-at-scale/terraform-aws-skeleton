/**
# terraform-aws-skeleton

A bare-bones Terraform module to be forked and turned into something useful.

| Branch | Build status |
| --- | --- |
| master | [![build Status](https://travis-ci.org/run-at-scale/terraform-aws-skeleton.svg?branch=master)](https://travis-ci.org/run-at-scale/terraform-aws-skeleton) |
| dev | [![build Status](https://travis-ci.org/run-at-scale/terraform-aws-skeleton.svg?branch=dev)](https://travis-ci.org/run-at-scale/terraform-aws-skeleton) |

## Usage example

Example code is contained in the [test/fixtures directory](test/fixtures). Here's
the gist of using this module via the Terraform registry:

    ```hcl
    module "this" {
      source  = "terraform-aws-modules/foo/aws"
      version = "0.1.0"
      vpc_id  = "${var.vpc_id}"

      tags {
        "Terraform" = "true"
        "Env"       = "${terraform.workspace}"
      }
    }
    ```

## Testing

This module has been packaged with tests as run through [test-kitchen](https://github.com/test-kitchen/test-kitchen)
via [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform). To
execute them:

    ```bash
    brew install rvm
    rvm install $(cat ./.ruby-version)
    gem install bundler
    bundle install
    bundle exec kitchen test
    ```

## Doc generation

Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs).
Generate them like so:

```bash
terraform-docs md ./ | cat -s | ghead -n -1 > README.md
```

## Best practices

This repo serves not only as an example of a skeleton repo but also a living document
of terraform best practices from the author's perspective. Those have been written
in detail under the [BEST_PRACTICES](docs/BEST_PRACTICES.md) doc.

## Contributing

Report issues/questions/feature requests in the [issues](https://github.com/run-at-scale/terraform-aws-skeleton/issues) section.

Pull requests are welcome! Ideally create a feature branch and issue for every
individual change made. These are the steps:

1. Fork the repo to a personal space or org.
2. Create your feature branch from master (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Added some feature for my awesome use case'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new Pull Request (showing tests pass) and tell us about your changes.

## Changelog

The [changelog](CHANGELOG.md) captures all important release notes.

## Authors

Created and maintained by [Brandon O'Connor](https://github.com/brandoconnor) with
help from these fine [contributors](https://github.com/run-at-scale/terraform-aws-skeleton/graphs/contributors).

## License

MIT Licensed. See [LICENSE](LICENSE) for full details.

*/

terraform {
  required_version = "~> 0.11.0"
}

provider "aws" {
  version = "1.9.0"
}
