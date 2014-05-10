class CommentsController < ApplicationController
  before_filter :authenticate_user!
  expose(:post)
  expose(:comment, attributes: :comment_params)

  def new
  end

  def create
    if comment.save
      redirect_to post_path(post)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(
      user_id: current_user.id,
      post_id: post.id
    )
  end
end
