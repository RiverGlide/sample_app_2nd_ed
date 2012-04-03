require_relative '../../../features/support/riverglide/web_user.rb'
include RiverGlide::WebUser

describe RiverGlide::WebUser do
  # Note: Here we're mocking what we don't own[GOOS book].
  #       We'd not normally do that but had to make a 
  #       compromise here temporarily.

  it "complains when it can't find a field name for a detail" do
    form = {'email' => 'email_address'}
    details = {'name' => 'andy'}

    stub!(:fill_in)

    expect do
      fill_in_the form, details
    end.to raise_error(RiverGlide::FormFieldNotFoundComplaint)
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
