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

  def vote_up
    vote(1)
  end

  def vote_down
    vote(-1)
  end

  private

  def comment_params
    return if %w{vote_up vote_down}.include? action_name
    params.require(:comment).permit(:body).merge(
      user_id: current_user.id,
      post_id: post.id
    )
  end

  def vote value
    vote = comment.votes.build(user: current_user, value: value)
    if vote.save
      redirect_to post_path(post), notice: "Thank you for your vote"
    else
      redirect_to post_path(post), alert: "You cannot vote again"
    end
  end
end
