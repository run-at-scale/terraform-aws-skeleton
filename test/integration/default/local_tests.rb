require 'awspec'
require 'Rhcl'

default_vars = Rhcl.parse(File.open('variables.tf').read())
fixture_override_vars = Rhcl.parse(File.open('examples/test_fixtures/variables.tf').read())
# FIXME: why does this not work to merge the hashes?
final_vars = default_vars.merge(fixture_override_vars)
# puts final_vars
# source from fixture first, default vars second
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
