class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end


  def current
    @user = @login_user
    render :show
  end

  def create
    auth_hash = request.env["omniauth.auth"]
    user = User.find_by(uid: auth_hash[:uid], provider: params[:provider])
      if user
        flash[:success] = "Logged in as returning user #{user.username}"
      else
        user = User.build_from_github(auth_hash)
        if user.save
          flash[:success] = "Logged in as new user #{user.username}"
        else
          flash[:error] = "Couldn't create a user account #{user.errors.messages}"
          return redirect_to root_path
        end
      end
    session[:user_id] = user.id
    redirect_to root_path
  end


  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
