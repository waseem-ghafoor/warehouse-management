# config/initializers/active_storage.rb
Rails.application.config.after_initialize do
  ActiveStorage::Current.url_options = {
    protocol: Rails.env.production? ? 'https' : 'http',
    host: Rails.application.routes.default_url_options[:host] || 'localhost',
    port: Rails.env.production? ? nil : 3000
  }
end
