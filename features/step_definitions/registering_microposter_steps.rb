GREEDY_CAPTURE='(.*)'
MESSAGES='(.*[^\'])'
ADDRESS=GREEDY_CAPTURE
PROBLEMS=GREEDY_CAPTURE

Before do
  @assistant = Assistant.new
end

def start_registration
  visit '/'
  click_on 'Sign up now!'
  page.should have_content 'Sign up'
  page.should have_button 'Create my account'
end

class Assistant
  def remember_the relevant, information
    @notepad ||= {}
    @notepad[relevant] = information
  end

  def recall_the memory
    @notepad[memory]
  end
end

Given /^I have started registration$/ do
  start_registration
end

Given /^I find this advice helpful$/ do |problem_advice|
  for_these_problems = problem_advice.rows_hash
  @assistant.remember_the :advice, for_these_problems
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
  @assistant.remember_the :user_name, details['name']
end

Then /^I should see that I am registered$/ do
  user_name = @assistant.recall_the :user_name
  page.should have_css('.alert-success', text: 'Welcome to the Sample App!')
  page.should have_css('h1', text: user_name)
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
