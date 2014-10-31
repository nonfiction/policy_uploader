require 'sinatra'
require './lib/db'
require './models'

get '/' do
  erb :index
end

get '/policies/new' do
  erb :new_policy
end

post '/policies' do
  p = Policy.new
  p.bucket_url = params[:bucket_url]
  p.origin = params[:origin]
  p.access_key_id = params[:access_key_id]
  p.secret_access_key = params[:secret_access_key]
  if p.valid?
    p.save
    content_type :text
    p.endpoint_url
  else
    @errors = p.errors
    erb :new_policy
  end
end

get '/policies/:endpoint_hash' do
  policy = Policy.where(:endpoint_hash => params[:endpoint_hash]).first
  content_type :json
  if policy
    {
      :policy => policy.policy,
      :signature => policy.signature,
      :bucket => policy.bucket_url,
      :access_key_id => policy.access_key_id
    }.to_json
  else
    {:eror => 'policy not found'}.to_json
  end
end

get '/style.css' do
  less :style
end
