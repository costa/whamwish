RSpec.configure do |config|
  config.before :each do
    allow_any_instance_of(Firebase::Client).to receive(:set).and_return(double :success? => true)
  end
end
