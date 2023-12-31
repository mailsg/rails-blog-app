class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @current = current_user
    @post = Post.find(params[:post_id])
    @new_comment = @post.comments.build(text: comment_parameters[:text], author_id: @current.id)
    respond_to do |format|
      format.html do
        if @new_comment.save
          redirect_to user_post_path(current_user, @post), notice: 'Comment created successfully'
        else
          redirect_to user_post_path(current_user, @post), alert: 'Cannot create comment'
        end
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@comment.post), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
