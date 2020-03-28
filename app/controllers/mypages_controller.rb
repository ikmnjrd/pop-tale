class MypagesController < ApplicationController
  def show
    @user = current_user
    @painting = @user.paintings.build
    @gallery_items = @user.gallery.paginate(:page => params[:page], :per_page => 30).order(id: :desc)
  end

  def aaab
  end

  def purchases
    @user = current_user
    @painting = @user.paintings.build
    @gallery_items = Painting.where(purchase_id: @user.id).paginate(:page => params[:page], :per_page => 30).order(id: :desc)
  end
end
