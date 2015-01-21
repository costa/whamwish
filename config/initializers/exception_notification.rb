if defined?(ExceptionNotification) && Rails.application.secrets.exception_notification_email.present?
  Whamwish::Application.config.middleware.use(ExceptionNotification::Rack,
    email: {
      email_prefix: "WhamWish RTE: ",
      sender_address: %{"WhamWish notifier" <notifier@#{Rails.application.secrets.domain_name}>},
      exception_recipients: [Rails.application.secrets.exception_notification_email]
    }
  )
end
