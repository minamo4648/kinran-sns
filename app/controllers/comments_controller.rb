class CommentsController < ApplicationController

  def create
      
    @tanka = Tanka.find(params[:comment][:tanka_id])
    @comments = @tanka.comments
    @comment = @comments.build(comment_params)   
    
    @notice = Notice.new
    @notice.body = "「#{view_context.shorten(@tanka.body, 15)}」に新しくコメントがつきました"
    @notice.link = "/tankas/#{@tanka.id}"
    @notice.save
    @users = User.where('id in (?)', @tanka.comments.group(:user_id).pluck(:user_id) | [ @tanka.user.id ])
                  .where('id != ?',current_user.id)
    @notice.note(@users)
    
    if @comment.save
      redirect_to :back, notice: "投稿が完了しました"
    else
      redirect_to :back, alert: "投稿できませんでした"
    end

  end
  
  def edit
  
    @comment = Comment.find(params[:id])
    @tanka = @comment.tanka

  end
  
  def update
    @comment = Comment.find(params[:id])
    @tanka = @comment.tanka
    
    if @comment.update(comment_params)
      redirect_to @tanka, notice: "更新が完了しました"
    else
      redirect_to :back
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
