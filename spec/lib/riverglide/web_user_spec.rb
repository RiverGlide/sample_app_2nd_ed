require_relative '../../../features/support/riverglide/web_user.rb'
require 'capybara'
require 'capybara/dsl'
include RiverGlide::WebUser

Capybara.run_server = false
Capybara.app = lambda {|env| [200, {'Content-Type' => 'text/plain'}, ['Stubbed!']]}

describe RiverGlide::WebUser do

  include Capybara::DSL

  it "complains when it can't find a field name for a detail" do
    form = {'email' => 'email_address'}
    details = {'name' => 'andy'}

    expect do
      fill_in_the form, details
    end.to raise_error(RiverGlide::WebUserComplaint)
  end

  it "fills in the form using the form fields and details provided" do
    form = {'name' => 'user_name'}
    details = {'name' => 'andy'}

    stub!(:fill_in) do |field_name, values|
      field_name.should == form.fetch('name')
      values.should == { with: details.fetch('name') }
    end

    fill_in_the form, details
  end
end
