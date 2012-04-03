module RegisteringMicroblogger
  def start_registration
    visit '/'
    click_on 'Sign up now!'
    page.should have_content 'Sign up'
    page.should have_button 'Create my account'
  end

  def i_should_be_registered_as someone
    page.should have_css('.alert-success', text: 'Welcome to the Sample App!')
    page.should have_css('h1', text: someone)
  end
end

