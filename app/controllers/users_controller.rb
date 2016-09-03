class UsersController < ApplicationController
  before_action :logged_in_user, only: [:followings]
  
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
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end

