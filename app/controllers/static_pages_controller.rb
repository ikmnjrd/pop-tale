class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = Painting.where(purchase_id: nil).paginate(:page => params[:page], :per_page => 30).order(id: :desc)
      @custom_paginate_renderer = custom_paginate_renderer
    else
      @feed_items = []
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def service_term
  end

  def privacy_policy
  end

  def sell
    @user = current_user
    @painting = current_user.paintings.build
  end

end
