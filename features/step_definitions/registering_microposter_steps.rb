GREEDY_CAPTURE='(.*)'
MESSAGES='(.*[^\'])'
ADDRESS=GREEDY_CAPTURE
PROBLEMS=GREEDY_CAPTURE
  

def start_registration
  visit '/'
  click_on 'Sign up now!'
  page.should have_content 'Sign up'
  page.should have_button 'Create my account'
end

Given /^I find this advice helpful$/ do |problem_advice|
  @problem_advice = problem_advice.rows_hash
Given /^I have started registration$/ do
  start_registration
end

end

When /^I complete registration with the following:$/ do |table|
  registration_page = {
    'name'                  => 'user_name',
    'email'                 => 'user_email',
    'password'              => 'user_password',
    'password confirmation' => 'user_password_confirmation'
  }
  details = table.rows_hash
  fill_in registration_page['name'], :with => details['name']
  fill_in registration_page['email'], :with => details['email']
  fill_in registration_page['password'], with: details['password']
  fill_in registration_page['password confirmation'], with: details['password confirmation']
  click_on 'Create my account'
  @user_name = details['name']
end

Then /^I should see that I am registered$/ do
  page.should have_css('.alert-success', text: 'Welcome to the Sample App!')
  page.should have_css('h1', text: @user_name)
end

Given /^someone has registered with the email '#{ADDRESS}'$/ do |email|
  Factory(:user, :email => email)
end

Then /^I should be advised on how to deal with these #{PROBLEMS}$/ do |problems|
  expected_problems = problems.split(', ')
  expected_advisories = expected_problems.inject([]) {|messages, problem| messages << @problem_advice[problem] }
  expected_advice = expected_advisories.join(" ")
  number_of_errors_expected = expected_problems.size

  number_of_errors_reported = page.find('.alert').text.match(/(\d+)/)[1].to_i
  number_of_errors_reported.should == number_of_errors_expected

  page.should have_content expected_advice
end
