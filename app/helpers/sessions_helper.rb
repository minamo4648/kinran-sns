module SessionsHelper

  def logged_in?
    !!current_user
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end