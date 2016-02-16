class VotershipsController < ApplicationController
    
#   <% if current_user.have? item %>
#     <%= render 'items/unhave' , item: item %>
#   <% else %>
#     <%= render 'items/have' , item: item %>
#   <% end %>

# _have

# <%= link_to "" , ownerships_path(item_id: item.id , type: "Have") ,
#                       :class => "have-#{item.id} btn-have btn btn-warning btn-sm have",
#                       :remote => true,
#                       :method => :post %>


#   resources :ownerships, only: [:create, :destroy]

#   ownerships POST   /ownerships(.:format)        ownerships#create
#     ownership DELETE /ownerships/:id(.:format)    ownerships#destroy    

before_action :authenticate_user!

  def create
      
      @tanka = Tanka.find(params[:tanka_id])

      if params[:type] == "Kin"
      
        current_user.kin(@tanka)
      
      end
      
      if params[:type] == "Ran"
      
        current_user.ran(@tanka)
      
      end
    
      if params[:type] == "Sho"
      
        current_user.sho(@tanka)
      
      end

  redirect_to :back

  end

  def destroy
      
    @tanka = Tanka.find(params[:tanka_id])

        if params[:type] == "Kin"
        
        kin = current_user.unkin(@tanka)
        kin.destroy if kin
        
        end
        
        if params[:type] == "Ran"
        
        ran = current_user.unran(@tanka)
        ran.destroy if ran
        
        end
    
        if params[:type] == "Sho"
        
        sho = current_user.unsho(@tanka)
        sho.destroy if sho
        
        end

  end
  
  def redo
    
    if current_user.kin_tankas.where(dai_id: params[:dai_id]).present?
      
      current_user.unkin(current_user.kin_tankas.where(dai_id: params[:dai_id]).first)
      
    end

    if current_user.ran_tankas.where(dai_id: params[:dai_id]).present?
      
      current_user.unran(current_user.ran_tankas.where(dai_id: params[:dai_id]).first)
      
    end
    
    if current_user.sho_tankas.where(dai_id: params[:dai_id]).present?
      
      current_user.unsho(current_user.sho_tankas.where(dai_id: params[:dai_id]).first)
      
    end
    
    redirect_to :back
    
  end
    
end
