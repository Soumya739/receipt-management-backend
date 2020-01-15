class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :city, :state, :country, :contact_num, :gender
end
