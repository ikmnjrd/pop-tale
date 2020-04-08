class UsersController < ApplicationController
  # before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # devise用のbeforeアクション
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  include ApplicationHelper

  def index
    @users = User.where.not(confirmed_at: nil).paginate(:page => params[:page], :per_page => 30).order(id: :asc)
    @custom_paginate_renderer = custom_paginate_renderer
  end

  def show
    @user = User.find(params[:id])
    if current_user?(@user)
      #アクティベートされていないものも表示
      @gallery_items = @user.gallery.paginate(:page => params[:page], :per_page => 30).order(id: :desc)
    else
      #アクティベートされていないものは表示しない
      @gallery_items = @user.others_gallery.paginate(:page => params[:page], :per_page => 30).order(id: :desc)
    end
    
    # unless以下の文はもともと「@user.activated?」
    redirect_to root_url and return unless @user.active_for_authentication?
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar)
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end


end
