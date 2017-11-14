class CommentsController < ApplicationController
  before_action :set_trip

  # GET /trips/:trip_id/comments
  def index
    comments =
      HTTParty
      .get("#{ENV["YT_COMMENT_API_URL"]}/trips/#{params[:id]}/comments")
      .as_json["data"]

    users = User.where(id: comments.map{|comm| comm["user_id"]})
    users = custom_serializer(users, UserSerializer).as_json

    comments = comments.map! do |comment|
      comment.merge(user: users.find{|user| user[:id] == comment["user_id"].to_i})
    end

    render json: comments
  end

  # POST /trips/:trip_id/comments
  def create
    if comment_params[:user_id] == current_user.id
      comment =
        HTTParty
        .post(
          "#{ENV["YT_COMMENT_API_URL"]}/comments",
          body: {
            comment: comment_params.as_json
        }).as_json["data"]

      comment["user"] = custom_serializer([User.find(current_user.id)], UserSerializer).as_json[0]
      broadcast(comment)
      render json: comment
    else
      render json: "ERROR", status: :unauthorized
    end
  end

  # DELETE /trips/:trip_id/comments/:id
  def destroy
    if params[:user_id] == current_user.id.to_s
      HTTParty.delete("#{ENV["YT_COMMENT_API_URL"]}/comments/#{params[:id]}")
    else
      render json: "ERROR", status: :unauthorized
    end
  end

  private

  def set_trip
    @trip = Trip.find params[:trip_id] || comment_params[:trip_id]
  end

  def comment_params
    params.require(:comment).permit(:id, :user_id, :trip_id, :message)
  end
end
