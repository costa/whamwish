RSpec.configure do |config|
  config.before :each do
    allow(Firebase::Client).to receive(:new).and_return double(:set => double(:success? => true))
  end
end
