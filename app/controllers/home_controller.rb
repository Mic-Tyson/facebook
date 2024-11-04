class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user

    @posts = @user.following_posts
  end
end
