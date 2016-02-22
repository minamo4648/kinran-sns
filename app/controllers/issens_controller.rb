class IssensController < ApplicationController
    
    def new
    
        @tanka = Tanka.find(params[:tanka_id])
        @issen = current_user.issens.build
    
    end

    def create
    
        @tanka = Tanka.find(params[:issen][:tanka_id])
        @issen = current_user.issens.build(issen_params)

    if @issen.save
            
        @notice = Notice.new
        @notice.body = "「#{shorten(@tanka.body, 15)}」に一撰評がつきました！"
        @notice.link = "/issens?tanka_id=#{@tanka.id}"
        @notice.save
        @users = [@tanka.user]
        @notice.note(@users)        
        
      redirect_to @tanka, notice: "投稿が完了しました"
    else
      redirect_to new_issen_path, alert: "投稿できませんでした"
    end
    
    end    

    def edit
    
        @tanka = Tanka.find(params[:tanka_id])
        @issen = @tanka.issens.where('user_id = ?', current_user.id).first
    
    end

    def update
    
        @tanka = Tanka.find(params[:issen][:tanka_id])
        @issen = @tanka.issens.where('user_id = ?', current_user.id).first

    if @issen.update(issen_params)
      redirect_to @tanka, notice: "投稿が完了しました"
    else
      redirect_to :back, alert: "投稿できませんでした"
    end
    
    end    
    
  def destroy

        @issen = Issen.find(params[:id])
        @tanka = @issen.tanka

    
    if @issen.destroy
      redirect_to @tanka, notice: "一撰評の削除が完了しました"
    else
      redirect_to :back, alert: "削除できませんでした"
    end    
    
  end    

  def index
  
    @tanka = Tanka.find(params[:tanka_id])
    @issens = @tanka.issens
  
  end

  private

    def issen_params
      params.require(:issen).permit(:body, :dai_id, :tanka_id)
    end
    

end
