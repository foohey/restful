module Restful
  class API < Grape::API
    format :json

    mount Restful::GetUser
    mount Restful::SearchUsers

    # Return a JSON formatted 404 error if url was not found
    # This configuration should be a the end of this class !!
    route :any, '*path' do
      error!( { message: "not found", status: 404 }, 404 )
    end
  end
end
