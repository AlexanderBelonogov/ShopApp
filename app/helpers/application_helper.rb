module ApplicationHelper
  def crypt
    @crypt ||= ActiveSupport::MessageEncryptor.new(Rails.configuration.secret_key_base)
  end
end
