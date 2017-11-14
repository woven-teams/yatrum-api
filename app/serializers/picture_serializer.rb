class PictureSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :url, :description, :public_id, :created_at, :updated_at
end
