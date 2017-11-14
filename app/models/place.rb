class Place < ApplicationRecord
  has_many :pictures
  belongs_to :trip, required: false # http://stackoverflow.com/a/39584972/1930053

  accepts_nested_attributes_for :pictures, :allow_destroy => true

  def place_pictures
    pictures
  end

end
