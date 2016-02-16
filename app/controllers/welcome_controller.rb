class WelcomeController < ApplicationController
  def index
    
    if authenticate_user!
        # @dais = Dai.all.order(due: :asc)
        @dais = listdais

    end
    
  end
end
