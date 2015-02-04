class Register < ActiveRecord::Base
  include Firebase::Ext::Writable

  def firebase_path; "registers/#{key}"; end

  self.primary_key = :key

  validates :key, :presence => true, :length => {:minimum => 16, :maximum => 255}
  validates :title, :subtitle, :length => {:maximum => 255}

end
