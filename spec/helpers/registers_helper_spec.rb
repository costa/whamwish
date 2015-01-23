require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RegistersHelper. For example:
#
# describe RegistersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RegistersHelper, :type => :helper do

  describe "register key <-> uri" do

    it "converts url to key" do
      expect(helper.register_uri_to_key "#{root_url}/#reg/1234-abcd-5678-ef90").to eq '1234-abcd-5678-ef90'
    end

    it "converts path to key" do
      expect(helper.register_uri_to_key "/#reg/1234-abcd-5678-ef90").to eq '1234-abcd-5678-ef90'
    end

    it "does not convert non-uri to key" do
      expect(helper.register_uri_to_key "#reg/1234abcd5678ef90").to be_nil
    end

    it "converts key to path" do
      expect(helper.register_key_to_path '1234-abcd-5678-ef90').to eq "/#reg/1234-abcd-5678-ef90"
    end

    it "converts key to url" do
      expect(helper.register_key_to_url '1234-abcd-5678-ef90').to eq "#{root_url}/#reg/1234-abcd-5678-ef90"
    end

  end

end
