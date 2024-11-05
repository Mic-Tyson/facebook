class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new user_params

    if @user.save
      redirect_to @user, notice: "Account creation successful!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  FOLLOW_ACTIONS = %w[follow unfollow request_follow unrequest_follow accept_follow_request deny_follow_request]

  FOLLOW_ACTIONS.each do |action|
  define_method(action) do
  @target = User.find_by(id: params[:user_id]) || User.find_by(id: params[:id])
  current_user.send(action, @target) if @target
    end
  end

  def remove_follower
    @target = User.find_by(id: params[:id])

    @target.unfollow(current_user)
  end


  def like
    likable = find_likable_type(params)

    if likable&.likable?
      current_user.like(likable)
      respond_to do |format|
        format.html { redirect_to likable }
      end
    else
      redirect_to root_path, alert: "Invalid likable content"
    end
  end

  private
  LIKABLE_TYPES = %w[Post Comment]
  # FOLLOW_ACTIONS = %w[follow unfollow request unrequest deny_request accept_request]

  def user_params
    params.require(:user).permit(%i[username email password bio pfp_url])
  end

  def find_likable_type(params)
    LIKABLE_TYPES.each do |type|
      if params["#{type.downcase}_id"]
        klass = type.constantize
        return klass.find_by(id: params["#{type.downcase}_id"])
      end
    end
    nil
  end
end
