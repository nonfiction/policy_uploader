require File.expand_path '../helper.rb', __FILE__

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "policy" do
  it "should create" do
    Policy.dataset.destroy
    p = Policy.new(bucket: 'test bucket_url', access_key_id: 'test access_key_id', secret_access_key: 'test secret_access_key')
    p.save
    Policy.all.length.must_equal 1
    p.bucket.must_equal 'test bucket_url'
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

describe "POST /policies" do
  let(:params) { {:bucket => 'test', :access_key_id => 'test', :secret_access_key => 'test'} }

  it "should succeed" do
    post '/policies', params
    last_response.status.must_equal 200
  end
end

