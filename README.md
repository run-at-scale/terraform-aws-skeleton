# terraform-aws-skeleton
A bare-bones Terraform module to be forked and turned into something useful.

[![master build Status](https://travis-ci.org/brandoconnor/terraform-aws-skeleton.svg?branch=master)](https://travis-ci.org/brandoconnor/terraform-aws-skeleton)
[![dev build Status](https://travis-ci.org/brandoconnor/terraform-aws-skeleton.svg?branch=dev)](https://travis-ci.org/brandoconnor/terraform-aws-skeleton)

## Assumptions

## Input Variables
* `aws_region` - Region to deploy our resources. (Required)
* `tags` - A mapping of tags to assign to the resource.

## Outputs
* `some_output` - description of output

## Usage example:
A full example leveraging other community modules is contained in the [examples/test_fixtures directory](examples/test_fixtures). Here's the gist of using it via the Terraform registry:
```
module "this" {
  source              = "terraform-aws-modules/alb/aws"
  vpc_id              = "${var.vpc_id}"

  tags {
    "Terraform" = "true"
    "Env"       = "${terraform.workspace}"
  }
}
```
3. Always `terraform plan` to see your change before running `terraform apply`.
4. Win the day!

## Importing existing infra
Discuss the various terraform import commands that could be run to get this module close to owning a set of existing live infra.

## Testing
This module has been packaged with [awspec]('https://github.com/k1LoW/awspec') tests through test kitchen. To run them:
1. Install the prerequisites of rvm and ruby 2.4.0 via homebrew.
2. Install bundler and the gems from our Gemfile:
```
gem install bundler; bundle install
```
3. Test using `kitchen test` from the root of the repo.

## Contributing
Report issues/questions/feature requests on in the [Issues](https://github.com/run-at-scale/terraform-aws-skeleton/issues) section.

Pull requests are welcome! Ideally create a feature branch and issue for every
individual change made. These are the steps:

1. Fork the repo to a personal space or org.
2. Create your feature branch from master (`git checkout -b my-new-feature`).
4. Commit your awesome changes (`git commit -am 'Added some feature'`).
5. Push to the branch (`git push origin my-new-feature`).
6. Create a new Pull Request and tell us about your changes.

## Change log
The [change log](CHANGELOG.md) captures all important release notes.

## Authors
Created and maintained by [Brandon O'Connor](https://github.com/brandoconnor) - brandon@atscale.run.

## License
MIT Licensed. See [LICENSE](LICENSE) for full details.
