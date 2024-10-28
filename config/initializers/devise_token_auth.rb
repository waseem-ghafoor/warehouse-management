# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.default_password_reset_url = "#{ENV['FRONTEND_URL']}#{ENV['RESET_PASSWORD_PATH']}"
  config.default_confirm_success_url = "#{ENV['FRONTEND_URL']}#{ENV['CUSTOMER_LOGIN_PATH']}"
  config.change_headers_on_each_request = false
  config.token_lifespan = 30.days
end
