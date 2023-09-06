class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 2)
  end

  def show
    @post = Post.includes(comments: :author).find(params[:id])
    @current = current_user
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @new_post = current_user.posts.build(post_parameters)
    respond_to do |format|
      format.html do
        if @new_post.save
          redirect_to user_post_path(current_user, @new_post), notice: 'Post created successfully.'
        else
          flash.now[:alert] = 'Please try again.'
          render :new
        end
      end
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(@user), notice: 'Post was successfully deleted.'
  end

  private

  def post_parameters
    params.require(:post).permit(:title, :text)
  end
end
