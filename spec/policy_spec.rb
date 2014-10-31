require File.expand_path '../helper.rb', __FILE__

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "policy" do
  it "should create" do
    Policy.dataset.destroy
    p = Policy.new(bucket_url: 'test bucket_url', origin: 'test origin', access_key_id: 'test access_key_id', secret_access_key: 'test secret_access_key')
    p.save
    Policy.all.length.must_equal 1
    p.bucket_url.must_equal 'test bucket_url'
    p.signature.length.must_equal 28 # not sure if this is true always...
    p.policy.length.must_equal 220 # not sure if this is true always...
  end
end

describe "GET /policies/new" do
  it "should render" do
    get '/policies/new'
    last_response.body.must_include 'Policy'
  end
end
