class Policy < Sequel::Model
  plugin :validation_helpers
  def validate
    super
    validates_presence [
      :bucket_url,
      :origin,
      :access_key_id,
      :secret_access_key,
      :endpoint_hash
    ]
  end

  def before_validation
    self.endpoint_hash ||= SecureRandom.uuid
  end

  def endpoint_url
    "https://example.com/policies/#{endpoint_hash}"
  end
end
