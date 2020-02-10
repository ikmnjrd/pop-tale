class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @painting = current_user.paintings.build
      @feed_items = current_user.feed
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
