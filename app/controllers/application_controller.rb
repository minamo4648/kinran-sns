class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  # deviceのコントローラーのときに、下記のメソッドを呼ぶ
  before_action :configure_permitted_parameters, if: :devise_controller?

# http://morizyun.github.io/blog/devise-customize-login-register-path/
  # def after_sign_in_path_for(resource)
  #   root_path
  # end

  # def after_sign_out_path_for(resource)
  #   root_path
  # end
  
  helper_method :new_notices
  
    def new_notices
      
      return current_user.notices.where("notices.created_at > ?", 1.weeks.ago ).order(created_at: :desc).limit(7)
      
    end

    def listdais
  
    return Dai.where('created_at >= ?', Time.zone.now - 2.week).order(due: :asc).where("target_gender = ? or target_gender = ?",0,current_user.gender)
        .where("target_grade like ? or target_grade = ?",  "%" + current_user.grade.to_s,"0").limit(30)
  
    end

  protected

    def configure_permitted_parameters
      # sign_inのときに、usernameも許可する
      devise_parameter_sanitizer.for(:sign_in) << :name
      # sign_upのときに、usernameも許可する
      devise_parameter_sanitizer.for(:sign_up) <<  [:name, :nickname, :nickname_update, :password, :password_confirmation, :grade, :gender, :holder ]
      #  account_updateのときに、usernameも許可する
      devise_parameter_sanitizer.for(:account_update) << [:name, :nickname, :nickname_update, :password, :password_confirmation ]
      
    end
  
end
