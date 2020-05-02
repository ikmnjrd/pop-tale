class MypagesController < ApplicationController
  def show
    @user = current_user
    @gallery_items = @user.gallery.paginate(:page => params[:page], :per_page => 30).order(id: :desc)
  end

  def sold
    @user = current_user
    @gallery_items = Painting.where(user_id: @user.id).where.not(purchase_id: nil).paginate(:page => params[:page], :per_page => 30).order(id: :desc)
  end

  def purchases
    @user = current_user
    @gallery_items = Painting.where(purchase_id: @user.id).paginate(:page => params[:page], :per_page => 30).order(id: :desc)
  end

  def connect_stripe
  end
end
