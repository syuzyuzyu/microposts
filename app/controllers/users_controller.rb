class UsersController < ApplicationController
  before_action :logged_in_user, only: [:followings, :edit]
  
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

  def followings
    @users = current_user.following_users.order(created_at: :desc)
  end
  
  def followers
    @users = current_user.follower_users.order(created_at: :desc)
  end

  def edit
    redirect_to root_path, :flash => {alert => "Don't edit other user!"} if !myself?
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
  
  def myself?
    @current_user = current_user
    @current_user.id.to_s == params[:id]
  end
end

