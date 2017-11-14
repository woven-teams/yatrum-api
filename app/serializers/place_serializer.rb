class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :review, :visited_date, :created_at, :updated_at

  has_many :pictures

  def visited_date
    if(object.visited_date)
      object.visited_date
    else
      object.created_at
    end
  end

end
