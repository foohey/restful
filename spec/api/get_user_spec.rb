require 'spec_helper'

describe Restful::GetUser do

    before :each do
      authorize( 'darius.mckay@mail.fr', 'pass' )
    end

    context "With existing user" do
      it 'should return a user' do
        get '/users/42'
        expect( last_response.body ).to have_node( :id ).with( 42 )
      end
    end

    context "With unknown id" do
      it "should return a 404 reponse"
      # do
        # get '/users/4242'
        # expect( last_response.status ).to eq( 404 )
        # expect( last_response.body ).to have_node( message: 'not found' )
      # end
    end

end
