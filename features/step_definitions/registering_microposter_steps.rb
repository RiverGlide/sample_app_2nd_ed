GREEDY_CAPTURE='(.*)'
MESSAGES='(.*[^\'])'
ADDRESS=GREEDY_CAPTURE
PROBLEMS=GREEDY_CAPTURE

Before do
  @assistant = RiverGlide::Assistant.new
end

def number_of_errors_on_this page
  page.find('.alert').text.match(/(\d+)/)[1].to_i
end

def number_of things
  list_of(things).size
end

def for_these things
  things.rows_hash
end
alias with_these for_these

World(
  SampleApp::RegisteringMicroblogger,
  SampleApp::CustomerServices,
  SampleApp::Advisor
)

Given /^I have started registration$/ do
  start_registration
end

Given /^I find this advice helpful$/ do |problem_advisories|
  @assistant.remember_the :advisories, for_these(problem_advisories)
end

When /^I complete registration with the following:$/ do |details|
  complete_registration with_these(details)
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
  i_should_see advice_for(expected_problems)
  number_of_errors_on_this(page).should == number_of(expected_problems)
end
