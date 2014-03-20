class UsersController < ApplicationController
  before_action :verify_user, :only => [:edit, :update, :destroy]

  def create
    @user = User.new(user_params)

    if password_confirmed?
      if @user.save
        login!(@user)
        redirect_to user_url(@user)
      else
        flash.now[:errors] = @user.errors.full_messages
        render :new
      end
    else
      flash.now[:errors] = ["password and confirmation do not match"]
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.is_password?(params[:user][:password])
      @user.destroy

      redirect_to new_user_url
    else
      flash.now[:errors] = ["incorrect password"]
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])

    render :edit
  end

  def new
    @user = User.new

    render :new
  end

  def show
    @user = User.find(params[:id])

    render :show
  end

  def update
    @user = User.find(params[:id])

    if @user.is_password?(params[:user][:password])
      if @user.update(user_params)
        redirect_to user_url(@user)
      else
        flash.now[:errors] = @user.errors.full_messages
        render :edit
      end
    else
      flash.now[:errors] = ["incorrect password"]
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def password_confirmed?
    params[:user][:password] == params[:user][:password_confirmation]
  end

  def verify_user
    user = User.find(params[:id])
    redirect_to user_url(current_user) unless current_user == user
  end
end
