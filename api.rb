module Restful
  class API < Grape::API
    format :json

    mount Restful::GetUser

  end
end
