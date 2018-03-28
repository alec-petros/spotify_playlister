class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    set_user
  end

  def spotify
    @user = User.find(session[:user_id])
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @user.spot_hash = spotify_user.to_hash
    @user.save
    redirect_to @user
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to signup_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :display_name, :password, :password_confirmation)
  end

end
