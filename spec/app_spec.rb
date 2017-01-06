require 'spec_helper'

require_relative '../app'

describe HelloWorldApp do
  describe 'GET /' do
    it 'should allow accessing the home page' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq("Hello, world!")
    end
  end
  describe 'GET /hello/pierre' do
    it 'should allow accessing the home page' do
      get '/hello/pierre'
      expect(last_response).to be_ok
      expect(last_response.body).to eq("Hello, pierre!")
    end
  end
  describe 'POST /' do
    it 'should allow accessing the home page' do
      post '/', {'move' => '1A'}
      expect(last_response).to be_ok
    end
  end
  describe 'GET /pierre' do
    it 'should allow accessing the home page' do
      get '/login'
      expect(last_response).to be_ok
      expect(last_response.body).to eq("Please login")
    end
  end
  describe 'POST /login' do
    it 'should allow accessing the home page' do
      post '/login', :name => "admin", :password => "pwd"
      expect(last_response).to be_ok
      expect(last_response.body).to eq("Succès")
    end
  end
  # :json => '{"fruits": [{"name": "Apple", "location": "Harbor"}, {"name": "Banana", "location": "Kitchen"}, {"name": "Mango", "location": "Bedroom"}]}',
  describe 'POST /evolve' do
    it 'should access to the param cells' do
      post '/evolve', :width => 2, :height => 1,
           :cells => {
               "myCells" => [
                   {
                       "x" => "1",
                       "y" => "1",
                       "state" => "alive"
                   }, {
                       "x" => "1",
                       "y" => "2",
                       "state" => "dead"
                   }
               ]
           }
      expect(last_response).to be_ok
      expect(last_response.body).to eq("1ère cell reçue is :alive height : 1 width : 2")
    end
  end
end