class CommentsController < ApplicationController

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.create(comment_params)
    respond_to do |format|
      format.html { redirect_to prototype_path(params[:prototype_id])  }
      format.json
    end
  end

  def edit
    @prototype = Prototype.find(params[:prototype_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @prototype = Prototype.find(params[:prototype_id])
    if @comment.user_id == current_user.id
      @comment.update_attribute('text', comment_params[:text])
      redirect_to prototype_path(@prototype)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id)
  end

end
