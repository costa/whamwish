if defined?(ExceptionNotification) && ENV['RUNTIME_ERROR_EMAIL'].present?
  Whamwish::Application.config.middleware.use(ExceptionNotification::Rack,
    email: {
      email_prefix: "WhamWish RTE: ",
      sender_address: %{"WhamWish notifier" <notifier@#{ENV['DOMAIN_NAME']}>},
      exception_recipients: [ENV['RUNTIME_ERROR_EMAIL']]
    }
  )
end
