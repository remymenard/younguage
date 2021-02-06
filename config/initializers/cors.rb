Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
       origins 'https://agile-island-59573.herokuapp.com'
       resource '*',
            headers: :any,
            methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
