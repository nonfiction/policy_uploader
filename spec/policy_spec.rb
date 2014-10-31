require File.expand_path '../helper.rb', __FILE__

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "policy" do
  let(:policy) { Policy.new }

  it "should create" do
    Policy.dataset.destroy
    policy.bucket_url = 'test bucket_url'
    policy.origin = 'test origin'
    policy.access_key_id = 'test access_key_id'
    policy.secret_access_key = 'test secret_access_key'
    policy.save
    Policy.all.length.must_equal 1
    Policy.first.bucket_url.must_equal 'test bucket_url'
  end
end

describe "GET /policies/new" do
  it "should render" do
    get '/policies/new'
    last_response.body.must_include 'Policy'
  end
end
