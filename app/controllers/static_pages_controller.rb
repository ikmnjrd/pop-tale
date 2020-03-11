class StaticPagesController < ApplicationController
  def home
    if logged_in?
      if params[:id]
        @feed_items = Painting.tagged_with("#{params[:id]}")
      else
        # これなんで必要なんだっけ？
        @painting = current_user.paintings.build
        @feed_items = current_user.feed
      end
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
