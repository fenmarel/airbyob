class SitesController < ApplicationController
  before_action :verify_owner, :only => [:edit, :update, :destroy]

  def create
    @site = current_user.sites.new(site_params)

    if @site.save
      redirect_to site_url(@site)
    else
      flash.now[:errors] = @site.errors.full_messages
      render :new
    end
  end

  def destroy
    @site = Site.find(params[:id])

    if current_user.is_password?(params[:user][:password])
      @site.destroy

      redirect_to user_owned_sites_url(current_user)
    else
      flash.now[:errors] = ["incorrect password"]
      render :edit
    end
  end

  def edit
    @site = Site.find(params[:id])

    render :edit
  end

  def index
    @sites = Site.all

    render :index
  end

  def new
    @site = Site.new

    render :new
  end

  def owned
    @user = User.find(params[:user_id])
    @sites = @user.sites

    render :owned
  end

  def update
    @site = Site.find(params[:id])

    if @site.update(site_params)
      redirect_to site_url(@site)
    else
      flash.now[:errors] = @site.errors.full_messages
      render :edit
    end
  end

  def show
    @site = Site.find(params[:id])

    render :show
  end

  private

  def site_params
    params.require(:site).permit(:title, :description, :location, :size, :price)
  end

  def verify_owner
    site = Site.find(params[:id])
    accessed_user = site.owner
    redirect_to root_url unless current_user == accessed_user
  end
end
