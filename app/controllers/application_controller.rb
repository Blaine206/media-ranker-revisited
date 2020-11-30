class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user

  def render_404
    return render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  # def require_login
  #   if @login_user.nil?
  #     flash[:error] = "You gotta log in to do that 😬"
  #     redirect_to root_path
  #   end
  # end

  private

  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end
end
