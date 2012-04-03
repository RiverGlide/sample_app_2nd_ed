GREEDY_CAPTURE='(.*)'
MESSAGES='(.*[^\'])'
ADDRESS=GREEDY_CAPTURE
PROBLEMS=GREEDY_CAPTURE

Before do
  @assistant = RiverGlide::Assistant.new
  @registration_form = {
    'name'                  => 'user_name',
    'email'                 => 'user_email',
    'password'              => 'user_password',
    'password confirmation' => 'user_password_confirmation'
  }
end

def start_registration
  visit '/'
  click_on 'Sign up now!'
  page.should have_content 'Sign up'
  page.should have_button 'Create my account'
end

def complete the_form, details
  fill_in the_form['name'], with: details['name']
  fill_in the_form['email'], with: details['email']
  fill_in the_form['password'], with: details['password']
  fill_in the_form['password confirmation'], with: details['password confirmation']
  click_on 'Create my account'
end

def i_should_be_registered_as someone
  page.should have_css('.alert-success', text: 'Welcome to the Sample App!')
  page.should have_css('h1', text: someone)
end

Given /^I have started registration$/ do
  start_registration
end

Given /^I find this advice helpful$/ do |problem_advice|
  for_these_problems = problem_advice.rows_hash
  @assistant.remember_the :advice, for_these_problems
end

When /^I complete registration with the following:$/ do |table|
  details = table.rows_hash
  complete @registration_form, details
  @assistant.remember_the :user_name, details['name']
end

Then /^I should see that I am registered$/ do
  user_name = @assistant.recall_the :user_name
  i_should_be_registered_as user_name
end

Given /^someone has registered with the email '#{ADDRESS}'$/ do |email|
  Factory(:user, :email => email)
end

Then /^I should be advised on how to deal with these #{PROBLEMS}$/ do |problems|
  expected_problems = problems.split(', ')
  expected_advisories = expected_problems.inject([]) {|advice, for_the_problem| advice << @assistant.recall_the(:advice)[for_the_problem] }
  expected_advice = expected_advisories.join(" ")
  number_of_errors_expected = expected_problems.size

  number_of_errors_reported = page.find('.alert').text.match(/(\d+)/)[1].to_i
  number_of_errors_reported.should == number_of_errors_expected

  page.should have_content expected_advice
end
