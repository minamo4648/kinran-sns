class WelcomeController < ApplicationController
  def index
    
     if user_signed_in?
         # @dais = Dai.all.order(due: :asc)
         @dais = listdais

     end
    
  end
end
