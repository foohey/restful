module Restful
  class GetUser < Grape::API
    get '/user/:id' do
      users = $DB[:user]
      user  = users[ id: params[ :id ] ]

      # Remove password from object
      user.delete( :password )

      return user
    end
  end
end
