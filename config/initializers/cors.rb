# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      valid_origins = ['localhost:3000']
      valid_origins.append(ENV['FRONTEND_DOMAIN']) if ENV['FRONTEND_DOMAIN'].present?
  
      origins(*valid_origins)
      resource "*",
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        expose:  %w[access-token expiry token-type uid client]
    end
  end