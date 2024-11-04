class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find params[:id]
  end

  def search
    @posts = Post.joins(:author)
                 .where("title ILIKE :query OR body ILIKE :query OR users.username ILIKE :query", query: "%#{Post.sanitize_sql_like(params[:query])}%")

    respond_to do |format|
      format.turbo_stream # turbo
      format.html { render :index } # non-turbo
    end
  end
end
