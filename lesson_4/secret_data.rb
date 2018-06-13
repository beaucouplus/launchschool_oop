class SecretFile
  def initialize(secret_data, security = SecurityLogger.new)
    @data = secret_data
    @security = security
  end

  def data
    security.create_log_entry
    @data
  end

  private
  attr_reader :security
end

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end
