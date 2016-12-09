class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user_id = current_user.id
    @comment.user_name = current_user.user_name
    if @comment.save!
      respond_to do |format|
        format.html { redirect_to :back }
        format.js {}
      end
    else
      render 'works/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end

  def find_commentable
   @commentable = Comment.find_by(id: params[:comment_id])     if params[:comment_id]
   @commentable = Work.find_by(id: params[:work_id])           if params[:work_id]
  end
end
