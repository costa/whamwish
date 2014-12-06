class Register < ActiveRecord::Base

  self.primary_key = :key
  validates :key, :presence => true

end
