# frozen_string_literal: true

Devise.setup do |config|
  require 'devise/orm/active_record'

  config.mailer_sender = ENV['MAILER_SENDER']

  config.mailer = 'DeviseMailer'

  config.parent_mailer = 'ApplicationMailer'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 8..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete
  config.scoped_views = true
end
