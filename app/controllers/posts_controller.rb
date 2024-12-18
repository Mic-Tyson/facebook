class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts = Post.order(created_at: :desc)
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

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    author = @post.author
    if author == current_user || current_user.username == "Mic Tyson"
      @post.destroy
      redirect_to user_path(author), notice: "Post was successfully deleted."
    else
      redirect_to user_path(author), alert: "You are not authorized to delete this post."
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :title, :file).merge(author_id: current_user.id)
  end
end
