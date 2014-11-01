require "base64"
require "json"

class Policy < Sequel::Model
  plugin :validation_helpers
  def validate
    super
    validates_presence [
      :bucket,
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

  def signature
    Base64.encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
        secret_access_key,
        policy
      )
    ).gsub(/\n/, '')
  end

  def policy
    Base64.encode64(
      {
        :expiration => (Time.now + 30*60).utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
        :conditions => [
          { :bucket => bucket },
          { :acl => 'public-read' },
          { :success_action_status => '201' },
          ['starts-with', '$key', '']
        ]
      }.to_json
    ).gsub(/\n|\r/, '')
  end
end
