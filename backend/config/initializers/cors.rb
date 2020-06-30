Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # This is just for demo purposes! :)
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end
