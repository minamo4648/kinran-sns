class TankasController < ApplicationController

before_action :authenticate_user!
before_action :tanka_confirm!, only: [:edit, :show] 
before_action :toko_judge!, only: [:new] 
before_action :edit_judge!, only: [:edit] 
before_action :fase3_judge!, only: [:index] 

    
  def new

    @tanka = current_user.tankas.build
    @dai_id = params[:dai_id].to_i
    @dai = Dai.find(params[:dai_id])
    
  end
  
  def create
    
    @tanka = current_user.tankas.build(tanka_params)
    @tanka.submitted_at = Time.zone.now
    
    if @tanka.save
      redirect_to root_path, notice: "投稿が完了しました"
    else
      redirect_to new_tanka_path
    end

  end
  
  def edit
    
    @tanka = Tanka.find(params[:id])
    @dai = @tanka.dai
  
  end

  def update
      
    @tanka = Tanka.find(params[:id])
    @tanka.submitted_at = Time.zone.now    
    
    if @tanka.update(tanka_params)
      redirect_to root_path, notice: "投稿が完了しました"
    else
      redirect_to edit_tanka_path
    end

  end

  def index
    
      @dai = Dai.find(params[:dai_id])
      @dai.vote_count #フェイズ切り替わりのときだけのほうがよい

      @tankas = Dai.find(params[:dai_id]).tankas.where(selected: true).order(kin_cnt: :desc, ransho_cnt: :desc, submitted_at: :asc, id: :asc)
      @ran_tanka = Dai.find(params[:dai_id]).tankas.order(ran_cnt: :desc, kin_cnt: :desc, ransho_cnt: :desc, submitted_at: :asc).first
      @sho_tanka = Dai.find(params[:dai_id]).tankas.order(sho_cnt: :desc, kin_cnt: :desc, ransho_cnt: :desc, submitted_at: :asc).first

  end  
  
  def show
  
    @tanka = Tanka.find(params[:id])
    @comments = @tanka.comments.order(created_at: :desc)
    @comment = @comments.build

  end

  def destroy

        @tanka = Tanka.find(params[:id])

    if @tanka.destroy
      redirect_to root_path, notice: "作品の削除が完了しました"
    else
      redirect_to :back, alert: "削除できませんでした"
    end    
    
  end  
  
  def soul
    
    current_user.update(soultanka_id: params[:id])
    
    redirect_to :back
    
  end

  def unsoul
    
    current_user.update(soultanka_id: nil)
    
    redirect_to :back
    
  end

  def expose
    
    @tanka = Tanka.find(params[:id])
    
    if @tanka.exposed != true
    
      @tanka.update(exposed: true)
    
    else
    
      @tanka.update(exposed: false)
      
      if current_user.soultanka_id == @tanka.id
        current_user.update(soultanka_id: nil)
      end      
        
    end
    
    redirect_to :back
    
  end

  def select
    
    @dai = Dai.find(params[:dai_id])
    @tanka = Tanka.find(params[:id])
    
    if @tanka.selected != true
    
        @tanka.update(selected: true)
    
    else
      
      if @dai.all_select == false    
        @tanka.update(selected: false)
      end 
      
    end
    
    redirect_to "/dais/" + params[:dai_id] + "/edit#t"
    
  end

  def voters
    
    @tanka = Tanka.find(params[:id])
    @voterships = @tanka.voterships
    @kins = @voterships.where(type: "Kin")
    @rans = @voterships.where(type: "Ran")
    @shos = @voterships.where(type: "Sho")
    
  end

  private

    def tanka_params
      params.require(:tanka).permit(:body, :dai_id, :exposed, :submitted_at)
    end

    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end
    
    def tanka_judge!
    
      @tanka = Tanka.find(params[:id])
      
      if @tanka.exposed == false
    
        redirect_to :back, alert: 'その短歌は非公開です'
        return
    
      end
    
    end

    def toko_judge!
    
      @dai = Dai.find(params[:dai_id])

      if @dai.fase != 1
          redirect_to root_path, alert: '投稿期間を過ぎました'
        return
      end
      
      if @dai.tankas.where(user_id: current_user.id).present?
        redirect_to edit_tanka_path(@dai.tankas.where(user_id: current_user.id).first)
      end
    
    end

    def edit_judge!
    
      @tanka = Tanka.find(params[:id])

      if @tanka.user != current_user and current_user.admin == false
         redirect_to root_path, alert: '他の人の短歌は推敲できません'
        return
    
      end

      if @tanka.dai.fase != 1
          redirect_to root_path, alert: '投稿期間を過ぎました'
        return
      end
    
    end
    
    def tanka_confirm!
    
      unless Tanka.find_by(id: params[:id]).present?
        redirect_to root_path
      end
    
    end

    def fase3_judge!
    
      @dai = Dai.find(params[:id])
      
      if @dai.fase != 3 and current_user.admin == false
        redirect_to root_path
        return
      end
    
    end

end
