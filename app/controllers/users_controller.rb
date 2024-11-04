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

  def follow
    @target = User.find_by(id: params[:user_id])

    current_user.follow(@target)
  end

  def unfollow
    @target = User.find_by(id: params[:user_id])

    current_user.unfollow(@target)
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
