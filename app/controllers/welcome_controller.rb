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
end
