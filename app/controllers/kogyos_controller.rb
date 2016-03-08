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

    def advance
    
        @kogyo = Kogyo.find(params[:id])
        @rengas = Renga.where(kogyo_id: @kogyo.id, place: @kogyo.place)
        @vote_result = RengaVotership.joins(:renga).where(rengas: {place: @kogyo.place}).where(rengas: {kogyo_id: @kogyo.id}).group(:renga_id).order('count_renga_id desc').count('renga_id')
        @top_vote_number = @vote_result.values.first
        @top_ids = Array.new
        
        @vote_result.keys.each do |r_id|
            if @vote_result[r_id] == @top_vote_number
                @top_ids << r_id
            end
        end
    
        @top_renga = Renga.where('id in (?)', @top_ids).order(updated_at: :asc).first
        
        @top_renga.update(picked: true)
        @kogyo.update(place: @kogyo.place + 1)
    
        if @kogyo.pick_type == 0    
            @kogyo.update(next_due: Time.zone.now + @kogyo.thinking_hour.hour)
        end

        redirect_to :back
    
    end

    private

        def kogyo_params
            params.require(:kogyo).permit(:user_id, :place, :season, :hokku_name, :next_due, :voting_hour, :thinking_hour, :pick_type, :notice, :next_notice)
        end

        def renga_params
            params.require(:renga).permit(:user_id, :body, :kogyo_id, :place, :selected, :picked)
        end

end
