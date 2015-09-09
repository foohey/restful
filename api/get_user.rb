module Restful
  class GetUser < Grape::API
    get '/user/:id' do
      users = $DB[:user]
      user  = users[ id: params[ :id ] ]

      if user
        # Remove password from object
        user.delete( :password )

        return user
      else
        return { error: "User not found" }
      end
    end
  end
end
