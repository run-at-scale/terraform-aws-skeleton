# Best practices

"Best-practice" in any domain is at best a moving-target of general principals and
at worst a crutch when design decisions become hard to justify. This document attempts
to summarize (in words) what's worked well and what we've collectively learned about
building in Terraform to create stable, maintainable, understandable, and secure
systems.

Most of the design principles here are nothing more than well-known practices software
engineering adapted to Terraform's "way" (DRY, SOLID, proper dependency direction,
UNIX philosophy, etc.). The lack of really good examples combined with more unique
attributes of Terraform - namely, its declaritive nature - creates space for additional
practices worth outlining.

## Modules

Modules are a key building block in Terraform and a critical component to achieving
abstraction and reduced complexity in any project. Use them often, use them well,
and many of our design objectives will follow. This repo gives a good idea of what
a robust module should look like.

A discussion of what makes a well-built module is detailed in the [MODULES.md](docs/MODULES.md)
doc.

## Testing

Terraform testing is a core competency and a part of our special-sauce at NCS. It's
important/substantial enough to require its own document so read on about [testing here](docs/TESTING.md).

## Working within a live-repo

* State management

### Provisioners

* Draw lines in the sand
* be practical about rate of change

### CI/CD

* Build early
* Make the hurdles of acceptance obvious to reproducable locally
* connect dependencies wherever possible (between live-repo states, packer builds, etc.) - pub sub?
* Style, tests, dependent module builds.

## Naming

Just like all software domains, hard and incredibly important in Terraform. The consequence
of changing resource names can be far reaching. Here are a few guidelines:

### Repository Naming Convention

tf_provider_modulename - current naming

### File naming conventions

* For simple modules (fewer than X resources) use a single main.tf file
* For more complex modules use multiple files, break it out into multiple files variables.tf, outputs.tf, and secrets.tf are all standard TF file names.
* underscores_in_file_names.tf

### Variable naming

* Use underscores (no dashes)
* All lowercase
* Variables passed through multiple levels of modules should use the same name
* Must always provide description/type

### Resource naming

* Use underscores
* Don’t repeat the resource name
* Be as descriptive as possible

## Style nitpicks and miscellany

These naggy rules will help a dev write Terraform code in a syntacically excellent
way.

* Use `terraform fmt` always - in fact, have your editor do it on your behalf. Any editor worth its salt has a plugin/extension for this. The only caution around `fmt` is the occasional mangling of comments.
* Files should end with newlines. It should go without saying that all newline characters should be in the unix format LF.
* Trailing commas, where permitted, should be used as they promote consistency in all list items.
* Magic is totally possible in terraform
