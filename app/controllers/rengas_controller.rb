class RengasController < ApplicationController

before_action :authenticate_user!
    
    def new
        
        @rengas = Renga.where(kogyo_id: Kogyo.last.id, picked: true).order(place: :asc)
        @renga = Renga.new
        
    end

  def create
    
    @renga = current_user.rengas.build(renga_params)
    
    if @renga.save
        
        if Kogyo.last.pick_type == 1
            Kogyo.last.update(place: Kogyo.last.place + 1)
        end
      redirect_to root_path, notice: "投稿が完了しました"
    else
      redirect_to new_renga_path
    end

  end

  private

    def renga_params
      params.require(:renga).permit(:body, :place, :user_id, :kogyo_id, :picked)
    end
    
end
