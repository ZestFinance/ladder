module ApplicationHelper
  def gravatar_url(email, options = {})
    options.assert_valid_keys :size
    size = options[:size] || 32
    digest = email.blank? ? "0" * 32 : Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{digest}?d=mm&s=#{size}"
  end
end
