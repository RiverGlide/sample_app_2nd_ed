GREEDY_CAPTURE='(.*)'
MESSAGES='\'?(.*[^\'])\'?$'
ADDRESS=GREEDY_CAPTURE

Given /^I have started registration$/ do
  #Given I have opened the homepage
  visit '/'
  #When I click on the 'sign-up' button
  click_on 'Sign up now!'
  #Then I should see the registration page
  page.should have_content('Sign up')
end

When /^I complete registration with the following:$/ do |table|
  #When I fill in the name with <name>
  #And I fill in the email with <email>
  #And I fill in the password with <password>
  #And I fill in the confirmation with <confirmation>
  #And I click the create my account button
  table.map_column!('Field') do |field_name|
    prefix = "user_"
    prefix = "#{prefix}password_" if field_name =~ /confirmation/
    "#{prefix}#{field_name}"
  end

  table.hashes.each do |row|
    field = row.fetch('Field')
    value = row.fetch('Value')
    @username = value if field =~ /name/
    fill_in(field, :with => value)
  end
  click_on 'Create my account'
end

Then /^I should see that I am registered$/ do
  #Then I should see the message 'Welcome to the Sample App!'
  page.should have_css('.alert-success', :text => 'Welcome to the Sample App!')
  #And I should see my username as 'andy'
  page.should have_css('h1', :text => @username)
end

Given /^a user with the email '#{ADDRESS}' exists$/ do |email|
  Factory(:user, :email => email)
end

Then /^I should see (?:the|these) registration error #{MESSAGES}$/ do |messages|
  #Then I should see the form has <number> errors
  number_of_errors_reported = page.find('.alert').text.match(/(\d+)/)[1].to_i
  number_of_errors_expected = messages.split.count('*')
  number_of_errors_reported.should == number_of_errors_expected
  #Then I should see the <messages>
  page.should have_content messages
end
