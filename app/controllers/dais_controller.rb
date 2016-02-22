class DaisController < ApplicationController

before_action :authenticate_user!
before_action :dai_judge!, only: [:show, :vote] 
before_action :voter_judge!, only: [:vote]  
    
  def new
    
    @dai = Dai.new
    @selected = Array.new(6)
    
  end
  
  def create
      
    @dai = Dai.new(dai_params)

  if params[:grades].present?    
    @dai.target_grade = params[:grades].join(" ")
  end
    
    if @dai.save
      redirect_to root_path, notice: "出題が完了しました"
    else
      redirect_to new_dai_path
    end

  end

  def edit
    
    @dai = Dai.find(params[:id])
    @selected = Array.new(6)
    @tankas = Tanka.where('dai_id = ?',params[:id])
    
  end
  
  def update
      
    @dai = Dai.find(params[:id])
    @tankas = @dai.tankas

  if params[:grades].present?    
    @dai.target_grade = params[:grades].join(" ")
  end
  
  if @dai.all_select == true
      @tankas.update_all(selected: true)
  end

  if params[:no_due] == "checked"
  
    params[:dai][:due] = nil
  
  end
  
  if params[:no_due2] == "checked"
  
    params[:dai][:v_due] = nil
  
  end

  if params[:commit] == "投稿を締め切る" or params[:commit] == "入選歌を確定し、投稿を締め切る"
    @dai.update(fase: 2)
    
    @notice = Notice.new
    @notice.body = "「#{@dai.title}」の投稿が締め切られました"
    @notice.link = "/dais/#{@dai.id}"
    @notice.save
    @users = User.where('id in (?)', Tanka.where('dai_id = ?', @dai.id).pluck(:user_id))
    if @users.count > 0
      @notice.note(@users)
    end
  end  
  
  if params[:commit] == "投票を締め切る"
    @dai.update(fase: 3)
    
    @notice = Notice.new
    @notice.body = "「#{@dai.title}」の投票が締め切られました"
    @notice.link = "/dais/#{@dai.id}"
    @notice.save
    @users = User.where('id in (?)', Tanka.where('dai_id = ?', @dai.id).pluck(:user_id))
    if @users.count > 0
      @notice.note(@users)   
    end
  end  
    
    if @dai.update(dai_params)
      redirect_to root_path, notice: "更新が完了しました"
    else
      redirect_to new_dai_path
    end

  end

  def index

    # @dais = Dai.all.order(due: :asc)
        @dais = listdais
    
  end
  
  def show
  
    @dai = Dai.find(params[:id])  
  
  end
  
  def vote
    
    @dai = Dai.find(params[:id])
    @tankas = Tanka.where(dai_id: params[:id])
    
  end
  
  def manage
  
    @dais = Dai.where(user_id: current_user.id).limit(20)
  
  end

  def proceed
    
    @dai = Dai.find(params[:id])
    
    if @dai.fase == 2 and @dai.selecting
      @dai.update(selecting: false)
      @notice = Notice.new
      @notice.body = "「#{@dai.title}」の撰歌が終わりました"
      @notice.link = "dais/#{@dai.id}"
      @notice.save
      @users = User.where('id in (?)', Tanka.where('dai_id = ?', @dai.id).pluck(:user_id))
      if @users.count > 0
        @notice.note(@users)
      end
    else 
      @dai.update(fase: @dai.fase + 1)
    end
    
    redirect_to root_path
    
  end
  
  private

    def dai_params
    params.require(:dai).permit(:title, :comment, :due, :dai_id, :target_grade, :target_gender, 
    :user_id, :v_due, :all_select, :vote_closed, :comment2, :genre)
    end
    
    def dai_judge!
    
      @dai = Dai.find(params[:id])
      
      if view_context.judge_target(@dai) == false
    
        redirect_to dais_path, alert: 'そのお題は見られません'
        return
    
      end
      
      if @dai.fase == 3
        redirect_to tankas_path(dai_id: params[:id])
        return
      end
    
    end

    def voter_judge!
    
      @dai = Dai.find(params[:id])
      
      if @dai.vote_closed == true and @dai.tankas.where(user_id: current_user.id).present? == false
    
        redirect_to root_path, alert: '投稿者しか投票できないお題です'
        return
    
      end
      
      if @dai.fase != 2
    
        redirect_to root_path, alert: '投票期間ではありません'
        return
    
      end

      if @dai.selecting
    
        redirect_to root_path, alert: 'ただいま撰歌中です'
        return
    
      end
    
    end
  
end
