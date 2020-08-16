class StaticPagesController < ApplicationController
  before_action :check_stripe_uid, only: [:sell]

  def home
    if logged_in?
      @feed_items = Painting.where(purchase_id: nil).paginate(:page => params[:page], :per_page => 30).order(id: :desc)
      @custom_paginate_renderer = custom_paginate_renderer
    else
      @feed_items = []
    end
  end

  def sell
    @user = current_user
    @painting = current_user.paintings.build
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

  

  private

    # 画像アップロード前にstripe_uidを持ってるかどうか
    def check_stripe_uid
      unless current_user.stripe_uid.present?
        flash[:failed] = "ストライプの利用登録後にアップロードができるようになります。"
        redirect_to(mypages_path) unless current_user.stripe_uid.present?
      end
    end

end
