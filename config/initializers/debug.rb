if Rails.env.development?

  if ENV['RUBY_DEBUG_PORT'].present?
    Byebug.start_server ENV['DOMAIN_NAME'], ENV['RUBY_DEBUG_PORT'].to_i
  end

end
