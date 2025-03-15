if Rails.env.test?
  module Devise
    module Strategies
      class TestMode < Base
        def valid?
          mapping.to.respond_to?(:find_for_database_authentication)
        end

        def authenticate!
          user = mapping.to.find_for_database_authentication(email: params[:email])
          if user && user.valid_password?(params[:password])
            success!(user)
          else
            fail!('Invalid email or password')
          end
        end
      end
    end
  end

  Warden::Strategies.add(:test_mode, Devise::Strategies::TestMode)
end 