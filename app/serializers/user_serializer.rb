class UserSerializer < ActiveModel::Serializer
  attributes :email, :api_token
end
