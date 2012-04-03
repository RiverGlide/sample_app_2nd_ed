module SampleApp
  module CustomerServices
    def register_someone_with details
      Factory(:user, :email => details[:email])
    end
  end
end
