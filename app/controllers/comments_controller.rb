class CommentsController < ApplicationController

  def create
      
    @tanka = Tanka.find(params[:comment][:tanka_id])
    @comments = @tanka.comments
    @comment = @comments.build(comment_params)   
    
    if @comment.save
      redirect_to :back, notice: "投稿が完了しました"
    else
      redirect_to :back, alert: "投稿できませんでした"
    end

  end

  def destroy
    
    @comment = Comment.find(params[:id])
    
    @comment.update(deleted: true)
    
    redirect_to :back
  end
    
      private
      
        def comment_params
            params.require(:comment).permit(:body, :user_id)
        end
      
    
end
