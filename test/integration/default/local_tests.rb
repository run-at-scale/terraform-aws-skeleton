require 'awspec'
require 'rhcl'

default_vars = Rhcl.parse(File.open('variables.tf').read)
override_var_file = 'test/fixtures/default/variables.tf'
fixture_override_vars = Rhcl.parse(File.open(overrride_var_file).read)
baz = fixture_override_vars['variable']['baz'] || default_vars['variable']['baz']

tf_state = JSON.parse(File.open('.kitchen/kitchen-terraform/default-aws/terraform.tfstate').read())
main_state = tf_state['modules'].select {|x| x['path'] == ["root", "main"]}[0] # unsure if this will work in all cases
account_id = main_state['outputs']['account_id']['value']
caller_arn = main_state['outputs']['caller_arn']['value']
caller_user = main_state['outputs']['caller_user']['value']

describe account do
  its(:user_id) { should eq caller_user }
  # its(:account) { should eq account_id }
  its(:arn) { should eq caller_arn }
end

describe account_attribute('ec2') do
  its('supported_platforms') { should eq ["EC2", "VPC"] }
end
