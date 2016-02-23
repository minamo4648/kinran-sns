class WelcomeController < ApplicationController
  def index
    
     if user_signed_in?
         # @dais = Dai.all.order(due: :asc)
         @dais = listdais
         
         if Issen.count > 0
             @issen = Issen.limit(1).offset(Random.rand(1 .. Issen.count)-1).take
         end
     end
    
  end
  
  def inquiry
      
  end
  
  def send_message

     UserMailer.petition(params[:body],params[:name],params[:email]).deliver_later
     
     redirect_to root_path, notice: '送信しました'
      
  end
  
end
