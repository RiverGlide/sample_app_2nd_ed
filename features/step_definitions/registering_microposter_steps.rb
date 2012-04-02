GREEDY_CAPTURE='(.*)'
MESSAGES=GREEDY_CAPTURE
ADDRESS=GREEDY_CAPTURE

Given /^I have started registration$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I complete registration with the following:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then /^I should see that I am registered$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^a user with the email '#{ADDRESS}' exists$/ do |email|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see (?:the|these) registration error #{MESSAGES}$/ do |messages|
  pending # express the regexp above with the code you wish you had
end
