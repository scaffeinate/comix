class Api::V1::MinimalSuperheroSerializer < ActiveModel::Serializer
  attributes :id, :name, :universe
end
