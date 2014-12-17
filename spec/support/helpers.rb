RSpec.configure do |config|

  config.include Omniauth::Mock
  config.include Omniauth::SessionHelpers, type: :feature
  OmniAuth.config.test_mode = true

  config.include FormHelpers, type: :feature

end
