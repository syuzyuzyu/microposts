class UsersController < ApplicationController
  before_action :logged_in_user, only: [:followings, :followers, :edit]
  before_action :auth_user, only: [:edit, :update]
  
  def show # 追加
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def following
    @access_user = User.find(params[:user_id])
    @users = @access_user.following_users.order(created_at: :desc)
  end
  
  def followers
    @access_user = User.find(params[:user_id])
    @users = @access_user.follower_users.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) 
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :place, 
                  :password, :password_confirmation)
  end
  
  def auth_user
    @user = User.find(params[:id])
    redirect_to root_url unless @user == current_user
  end
end

