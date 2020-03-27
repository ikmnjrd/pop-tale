class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # これなんで必要なんだっけ？
      @painting = current_user.paintings.build
      #@feed_items = current_user.feed
      @feed_items = Painting.all.paginate(:page => params[:page], :per_page => 30).order(id: :desc)
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

end
