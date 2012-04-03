module RiverGlide
  module WebUser
    def i_should_see some_text
      page.should have_content some_text
    end

    def fill_in_the form, with_details
      with_details.each do |field, value|
        fill_in form[field], with: value 
      end
    end
  end
end
