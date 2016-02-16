class DaisController < ApplicationController

before_action :authenticate_user!
before_action :dai_judge!, only: [:show, :vote]    
    
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
      redirect_to dais_path, notice: "出題が完了しました"
    else
      redirect_to new_dai_path
    end

  end

  def edit
    
    @dai = Dai.find(params[:id])
    @selected = Array.new(6)
    
  end
  
  def update
      
    @dai = Dai.find(params[:id])

  if params[:grades].present?    
    @dai.target_grade = params[:grades].join(" ")
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
  
  private

    def dai_params
    params.require(:dai).permit(:title, :comment, :due, :dai_id, :target_grade, :target_gender, :user_id, :v_due, :all_select)
    end
    
    def dai_judge!
    
      @dai = Dai.find(params[:id])
      
      if view_context.judge_target(@dai) == false
    
        redirect_to dais_path, alert: 'そのお題は見られません'
        return
    
      end
    
    end
  
end
