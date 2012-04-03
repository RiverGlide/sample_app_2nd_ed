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

def complete the_form, details
  fill_in the_form['name'], with: details['name']
  fill_in the_form['email'], with: details['email']
  fill_in the_form['password'], with: details['password']
  fill_in the_form['password confirmation'], with: details['password confirmation']
  click_on 'Create my account'
end

def i_should_see some_text
  page.should have_content some_text
end

def number_of_errors_on_this page
  page.find('.alert').text.match(/(\d+)/)[1].to_i
end

def register_someone_with details
  Factory(:user, :email => details[:email])
end

def list_of problems
  problems.split ', '
end

def advice_for problems
  advisories = list_of(problems).inject([]) do |advice, for_the_problem| 
    advice << @assistant.recall_the(:advisories)[for_the_problem]
  end
  advisories.join(" ")
end

def number_of things
  list_of(things).size
end

def for_these things
  things.rows_hash
end
alias with_these for_these

World(RegisteringMicroblogger)

Given /^I have started registration$/ do
  start_registration
end

Given /^I find this advice helpful$/ do |problem_advisories|
  @assistant.remember_the :advisories, for_these(problem_advisories)
end

When /^I complete registration with the following:$/ do |details|
  complete @registration_form, with_these(details)
  @assistant.remember_the :user_name, with_these(details).fetch('name')
end

Then /^I should see that I am registered$/ do
  user_name = @assistant.recall_the :user_name
  i_should_be_registered_as user_name
end

Given /^someone has registered with the email '#{ADDRESS}'$/ do |address|
  register_someone_with email: address
end

Then /^I should be advised on how to deal with these #{PROBLEMS}$/ do |expected_problems|
  number_of_errors_on_this(page).should == number_of(expected_problems)
  i_should_see(advice_for expected_problems)
end
