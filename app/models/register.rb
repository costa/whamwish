class Register < ActiveRecord::Base

  self.primary_key = :key

  validates :key, :presence => true, :length => {:minimum => 16}  # XXX decent validation, see app/assets/javascripts/registers

end
