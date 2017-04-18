require 'rspec'

require_relative '../lib/controller'

describe Controller do
  let(:controller) { Controller.new }

  describe '#sayHi' do
    it "should return Hello world" do
      expect(controller.sayHi()).to eq "Hello, world!"
    end
  end

end
