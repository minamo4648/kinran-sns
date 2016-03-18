class UsersController < ApplicationController
  
before_action :authenticate_user!
before_action :admin_only, only: [:edit, :update, :index]  
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id]) 

    if @user.update_without_current_password(account_update)
      flash[:success] = "Update succeeded"
      redirect_to users_path
    else
      redirect_to :back
      return
    end
    
  end

  def show

    @user = User.find(params[:id])
    @soultanka = Tanka.find_by(id: @user.soultanka_id)
    #@tankas = @user.tankas.order(created_at: :desc)
    if @user == current_user
      @tankas = Tanka.where(user_id: @user.id).order(submitted_at: :desc).page(params[:page])
    else
      @tankas = Tanka.joins(:dai).where(dais: {fase: 3}).where(exposed: true).where(user_id: @user.id).order(submitted_at: :desc).page(params[:page])
    end
    @best_tanka = @tankas.where(dais: {fase: 3}).where(exposed: true).where("kin_cnt >= ?", 1).reorder(kin_cnt: :desc, ransho_cnt: :desc, created_at: :asc).first if @tankas.where("kin_cnt >= ?", 1).count > 0

  end
  
  def index
    
    #@users = User.order(current_sign_in_at: :desc).page(params[:page])

    @q      = User.search(params[:q])
    @users_all = @q.result(distinct: true)
    @users = @users_all.order(current_sign_in_at: :desc).page(params[:page])
    
  end

  def import_csv_new  
  end
    
  def import_csv
    @file = params[:csv_file]
    CSV.foreach(@file.path, headers: true) do |row|
     User.create(name: row[0],email: row[1], password: row[2], grade: row[3], gender: row[4])
    end
    redirect_to import_csv_new_path
  end

private

    def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
            :nickname, :nickname_update, :admin, :gender, :grade ,:holder, :contributor)
    end

    def account_update_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
          :nickname, :nickname_update, :admin, :gender, :grade ,:holder, :contributor)
    end

    def account_update
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
          :nickname, :nickname_update, :admin, :gender, :grade ,:holder, :contributor)
    end
    
    def admin_only
      
      if current_user.admin != true
        
        redirect_to root_path
        
      end
      
    end

end

