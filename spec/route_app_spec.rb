require 'spec_helper'

require_relative '../route_app'
require_relative '../lib/file_manager'
require_relative '../lib/controller'

describe RouteApp do
  describe 'GET /' do
    it 'should be ok' do
      get '/'
      expect(last_response).to be_ok
    end
    it 'should display content through controller' do
      get '/'
      expect(last_response.body).to eq("Hello, world!")
    end
  end

  describe 'GET /grids/:id' do
    before() do
      get '/newCreate/17432/height/1/width/1'
    end
    it 'should be ok' do
      get '/grids/17432'
      expect(last_response).to be_ok
    end
    it 'should set content type to application json' do
      get '/grids/17432'
      expect(last_response.content_type).to eq "application/json"
    end
    it 'should set CORS' do
      get '/grids/17432'
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq "*"
    end
    it 'should return parse body' do
      get '/grids/17432'
      expect(last_response.body).to include "[{\"x\":1,\"y\":1,\"state\":\""
    end
  end

  describe 'GET /grids/:id/count/alive' do
    before() do
      get '/newCreate/17432/height/1/width/1'
    end
    it 'should be ok' do
      get '/grids/17432/count/alive'
      expect(last_response).to be_ok
    end
    it 'should set CORS' do
      get '/grids/17432/count/alive'
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq "*"
    end
    it 'should return parse body' do
      get '/grids/17432/count/alive'
      zeroOrOne = last_response.body.to_i
      if (zeroOrOne == 0)
        expect(zeroOrOne).to eq 0
      else
        expect(zeroOrOne).to eq 1
      end
    end
  end

  describe 'GET /newCreate/:id/height/:height/width/:width' do
    it 'should be ok' do
      get '/newCreate/17432/height/1/width/1'
      expect(last_response).to be_ok
    end
    it 'should set content type to application json' do
      get '/newCreate/17432/height/1/width/1'
      expect(last_response.content_type).to eq "application/json"
    end
    it 'should set CORS' do
      get '/newCreate/17432/height/1/width/1'
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq "*"
    end
    it 'should return parse body' do
      get '/newCreate/17432/height/1/width/1'
      expect(last_response.body).to include "[{\"x\":1,\"y\":1,\"state\":\""
    end
  end
end