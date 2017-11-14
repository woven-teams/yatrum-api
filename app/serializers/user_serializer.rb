class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :instagram_access_token, :instagram_profile_picture,
             :instagram_user_name, :profile_pic, :cover_photo, :total_followers,
             :total_following, :total_trips, :is_followed_by_current_user,
             :facebook_url, :twitter_url, :instagram_url, :website_url,
             :blog_url

  def total_followers
    object.total_followers
  end

  def total_following
    object.total_following
  end

  def total_trips
    object.total_trips
  end

  def profile_pic
    if object.profile_pic
      object.profile_pic
    else
      { url: USER_CONSTANTS["default_profic_pic_male"], public_id: "" }
    end
  end

  def cover_photo
    if object.cover_photo
      object.cover_photo
    else  
      { url: USER_CONSTANTS["default_cover_photo"], public_id: "" }
    end
  end

  def is_followed_by_current_user
    current_user = User.current
    # if(object.id == 1)
    #   binding.pry
    # end
    return false unless current_user
    return false if current_user.id == object.id
    current_user.following.pluck(:id).include?(object.id)
  end

end
