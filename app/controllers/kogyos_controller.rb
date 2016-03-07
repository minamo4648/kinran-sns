class KogyosController < ApplicationController

before_action :authenticate_user!

    def new
    
        @kogyo = Kogyo.new
        @renga = Renga.new
    
    end

    def create
        @kogyo = Kogyo.new(kogyo_params)

        @renga = Renga.new(renga_params)
        
        
        unless @kogyo.save
            redirect_to new_kogyo_path
        end

        if @renga.save
            @renga.update(kogyo_id: Kogyo.last.id)
            redirect_to root_path, notice: "投稿が完了しました"
        else
            redirect_to new_kogyo_path
        end

    end

    def index
    
        @kogyos = Kogyo.where(place: 19).order(created_at: :desc).page(params[:page])
    
    end
    
    def show
    
        @kogyo = Kogyo.find(params[:id])
        @rengas = @kogyo.rengas.where(picked: true).order(place: :asc)
    
    end

    private

        def kogyo_params
            params.require(:kogyo).permit(:user_id, :place, :season, :hokku_name, :next_due, :voting_hour, :thinking_hour, :pick_type)
        end

        def renga_params
            params.require(:renga).permit(:user_id, :body, :kogyo_id, :place, :selected, :picked)
        end

end
