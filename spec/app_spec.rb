require 'spec_helper'

require_relative '../app'
# require_relative '../lib/file_manager'

describe RouteApp do
  describe 'GET /' do
    it 'should allow accessing the home page' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq("Hello, world!")
    end
  end

  describe 'GET /grid/:id' do
    xit 'should call getGrid' do
      file_manager = double('file_manager')
      expect(file_manager).to receive(:getGrid)
      expect(JSON).to receive(:load)
      get '/grid/100/'
    end
    it 'should return ok' do
      get '/grid/100/'
      expect(last_response).to be_ok
      # expect(last_response.body).to eq("{\"length\":10,\"height\":5,\"cells\":{\"[1, 1]\":\"dead\",\"[1, 2]\":\"dead\",\"[1, 3]\":\"dead\",\"[1, 4]\":\"dead\",\"[1, 5]\":\"dead\",\"[2, 1]\":\"dead\",\"[2, 2]\":\"dead\",\"[2, 3]\":\"dead\",\"[2, 4]\":\"dead\",\"[2, 5]\":\"dead\",\"[3, 1]\":\"dead\",\"[3, 2]\":\"dead\",\"[3, 3]\":\"dead\",\"[3, 4]\":\"dead\",\"[3, 5]\":\"dead\",\"[4, 1]\":\"dead\",\"[4, 2]\":\"dead\",\"[4, 3]\":\"dead\",\"[4, 4]\":\"dead\",\"[4, 5]\":\"dead\",\"[5, 1]\":\"dead\",\"[5, 2]\":\"dead\",\"[5, 3]\":\"dead\",\"[5, 4]\":\"dead\",\"[5, 5]\":\"dead\",\"[6, 1]\":\"dead\",\"[6, 2]\":\"dead\",\"[6, 3]\":\"dead\",\"[6, 4]\":\"dead\",\"[6, 5]\":\"dead\",\"[7, 1]\":\"dead\",\"[7, 2]\":\"dead\",\"[7, 3]\":\"dead\",\"[7, 4]\":\"dead\",\"[7, 5]\":\"dead\",\"[8, 1]\":\"dead\",\"[8, 2]\":\"dead\",\"[8, 3]\":\"dead\",\"[8, 4]\":\"dead\",\"[8, 5]\":\"dead\",\"[9, 1]\":\"dead\",\"[9, 2]\":\"dead\",\"[9, 3]\":\"dead\",\"[9, 4]\":\"dead\",\"[9, 5]\":\"dead\",\"[10, 1]\":\"dead\",\"[10, 2]\":\"dead\",\"[10, 3]\":\"dead\",\"[10, 4]\":\"dead\",\"[10, 5]\":\"dead\"}}")
    end
  end

  describe 'POST /create' do
    xit 'should create a file for the grid' do
      file_manager = double('file_manager')
      expect(file_manager).to receive(:create).with(10, 5).and_yield(100)
      post '/create', :length => "10", :height => "5"
      expect(last_response).to be_redirect
    end
    it 'should redirect to /grid/:id' do
      post '/create', :length => "10", :height => "5"
      expect(last_response).to be_redirect
      expect(last_response.location).to include("/grid/100")
    end
  end

end