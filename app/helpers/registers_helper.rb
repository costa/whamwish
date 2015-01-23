module RegistersHelper

  def register_uri_to_key(uri)
    anchor = uri.split('#').last
    anchor.match(/^reg\/(\h\h\h\h-\h\h\h\h-\h\h\h\h-\h\h\h\h)$/).try(:captures).try(:first)
  end

  def register_key_to_path(key)
    "/#reg/#{key}"
  end

  def register_key_to_url(key)
    "#{root_url}#{register_key_to_path key}"
  end

end
