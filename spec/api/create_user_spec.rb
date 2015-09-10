require 'spec_helper'

describe Restful::CreateUser do

    context "With normal user" do
      it 'should return return a 403 error ( forbidden )' do
        authorize( 'darius.mckay@mail.fr', 'pass' )
        post '/users', { firstname: 'foo' }
        expect( last_response.status ).to eq( 403 )
        expect( last_response.body ).to have_node( :message ).with( "Unauthorized" )
      end
    end

    context "With admin user" do
      before do
        authorize( 'kyla.walker@mail.fr', 'pass' )
      end

      context "With missing attributes" do
        it "should return a validation error" do
          post '/users'
          %w( email firstname lastname password role ).each do |attr|
            expect( last_response.body ).to have_node( :error ).including_text( "#{attr} is missing" )
          end
        end
      end

      context "When email is already taken" do
        it "should return a validation error" do
          post '/users', {
            firstname: 'foo',
            lastname:  'bar',
            email:     'kyla.walker@mail.fr',
            role:      'normal',
            password:  'pass',
          }
          expect( last_response.body ).to have_node( :email ).including_text( "is already taken" )
        end
      end
    end

end
