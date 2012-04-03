module RegisteringMicroblogger
  
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
    complete registration_form, with_details
  end

  def i_should_be_registered_as someone
    page.should have_css('.alert-success', text: 'Welcome to the Sample App!')
    page.should have_css('h1', text: someone)
  end

  #TODO: Move this somewhere more general and iterate over details instead
  def complete the_form, details
    fill_in the_form['name'], with: details['name']
    fill_in the_form['email'], with: details['email']
    fill_in the_form['password'], with: details['password']
    fill_in the_form['password confirmation'], with: details['password confirmation']
    click_on 'Create my account'
  end

end
