require 'spec_helper'

require_relative '../app'
require_relative '../lib/file_manager'

describe RouteApp do
  describe 'GET /' do
    it 'should allow accessing the home page' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq("Hello, world!")
    end
  end

  describe 'GET /grids/:id' do
    xit 'should call getGrid' do
      # file_manager = double('file_manager')
      # expect(file_manager).to receive(:getGrid)
      # expect(JSON).to receive(:load)
      get '/grids/100/'
    end
    it 'should call getGrid' do
      # file_manager = double('file_manager')
      # expect(file_manager).to receive(:getGrid)
      # expect(JSON).to receive(:load)
      get '/grids/100'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('[{"x":1,"y":1,"state":"dead"}]')
    end
  end

  describe 'POST /create' do
    xit 'should create a file for the grid' do
      file_manager = double('file_manager')
      expect(file_manager).to receive(:create).with(10, 5).and_yield(100)
      post '/create', :length => "10", :height => "5"
      expect(last_response).to be_redirect
    end
    xit 'should redirect to /grid/:id' do
      post '/create', :length => "10", :height => "5"
      expect(last_response).to be_redirect
      expect(last_response.location).to include("/grid/100")
    end
  end

  describe '/newCreate/:id/height/:height/width/:width' do
    it 'should give [ { x: 1, y:1, state : "dead" }]' do
      get '/newCreate/100/height/1/width/1'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('[{"x":1,"y":1,"state":"dead"}]')
    end
  end


end