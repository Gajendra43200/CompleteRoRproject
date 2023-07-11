class ServiceSerializer < ActiveModel::Serializer
  attributes :id ,:service_name,:address,:city, :status
end
