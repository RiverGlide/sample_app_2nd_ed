require_relative '../../../features/support/riverglide/assistant.rb'

describe RiverGlide::Assistant do

  it "complains when asked to recall information that has not been rememebered" do
    assistant = RiverGlide::Assistant.new
    expect do
      assistant.recall_the :information_that_has_not_been_rememebered
    end.to raise_error RiverGlide::Assistant::NoRecollectionComplaint
  end

  it "takes note of relevant information" do
    assistant = RiverGlide::Assistant.new
    assistant.remember_the :name, 'andy'
    assistant.remember_the :email, 'andy@example.com'
    assistant.recall_the(:name).should == 'andy'
    assistant.recall_the(:email).should == 'andy@example.com'
  end

end
