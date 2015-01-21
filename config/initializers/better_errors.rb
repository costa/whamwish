if defined?(BetterErrors) && Rails.application.secrets.better_errors_private_ip.present?
  BetterErrors::Middleware.allow_ip! Rails.application.secrets.better_errors_private_ip
end
