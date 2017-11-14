class Trip < ApplicationRecord
  acts_as_taggable
  acts_as_votable

  # Count Number of Impressions
  is_impressionable :counter_cache => true, unique: true
  
  has_many :places
  belongs_to :user, required: false # http://stackoverflow.com/a/39584972/1930053

  accepts_nested_attributes_for :places, :allow_destroy => true

  def pictures
    arr = []
    places.each do |place|
      arr.append(place.place_pictures)  
    end
    arr.flatten
  end


  def toggle_like(user)
    if voted_on_by? user
      unliked_by user
    else
      liked_by user
    end
  end
end
