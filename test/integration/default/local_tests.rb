require 'awspec'
require 'Rhcl'

module_vars = Rhcl.parse(File.open('examples/test_fixtures/variables.tf'))
# log_prefix = module_vars['variable']['log_prefix']['default']
tf_state = JSON.parse(File.open('.kitchen/kitchen-terraform/default-aws/terraform.tfstate').read)
# account_id = tf_state['modules'][0]['outputs']['account_id']['value']
