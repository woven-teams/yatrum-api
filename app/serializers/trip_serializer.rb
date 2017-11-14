class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :user_id,
    :is_liked_by_current_user, :trip_likes_count, :thumbnail_image_url,
    :view_count, :tag_list

  has_many :places
  belongs_to :user

  def is_liked_by_current_user
  	return false unless User.current
    object.voted_on_by? User.current    
  end

  def trip_likes_count
    object.get_likes.count
  end

  def thumbnail_image_url
    object.places.first.pictures.first.url
  rescue
    "http://res.cloudinary.com/zeus999/image/upload/h_300/v1483437708/sea-sky-beach-holiday-11_nnbuey.jpg" 
  end

  def view_count
    object.impressions_count
  end
end
