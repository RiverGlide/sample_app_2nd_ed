module WebUser
  def fill_in_the form, with_details
    with_details.each do |field, value|
      fill_in form[field], with: value 
    end
  end
end

module RegisteringMicroblogger
  include WebUser
  
  def registration_form 
    {
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

  def complete_registration with_details
    fill_in_the registration_form, with_details
    click_on 'Create my account'
  end

  def i_should_be_registered_as someone
    page.should have_css('.alert-success', text: 'Welcome to the Sample App!')
    page.should have_css('h1', text: someone)
  end
end
