class KogyosController < ApplicationController

    def new
    
        @kogyo = Kogyo.new
        @renga = Renga.new
    
    end

    def create
        @kogyo = Kogyo.new(kogyo_params)

        @renga = Renga.new(renga_params)
        @renga.save
        
        
        if @kogyo.save
            redirect_to root_path, notice: "投稿が完了しました"
        else
            redirect_to new_kogyo_path
        end
    end

    private

        def kogyo_params
            params.require(:kogyo).permit(:user_id, :place, :season, :hokku_name, :next_due, :voting_hour, :thinking_hour)
        end

        def renga_params
            params.require(:renga).permit(:user_id, :body, :kogyo_id, :place, :selected, :picked)
        end

end
