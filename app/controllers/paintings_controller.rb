class PaintingsController < ApplicationController
    #before_action :logged_in_user, only: [:create, :destroy]
    before_action :authenticate_user!, only: [:create, :destroy]
    before_action :correct_user,   only: :destroy
    before_action :no_judging_paint, only: :create

  def create
    @painting = current_user.paintings.build(painting_params)
    if @painting.save
      JudgmentMailer.new_registration(@painting).deliver_now
      flash[:info] = "審査の完了までしばらくお待ちください"
      redirect_to mypages_path
    else
      @feed_items = []
      flash[:Missing_elements] = "Missing elements"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @painting = Painting.find(params[:id])
    render "the_painting"
  end

  def edit
    correct_user
    @painting = Painting.find(params[:id])
    redirect_to painting_url unless @painting.activated?
  end

  def update
    @painting = Painting.find(params[:id])

    if @painting.price < params[:painting][:price].to_i
      flash[:price] = '元の値段より高い値段をつけたい場合はサポートへ連絡をお願いいたします。'
      render 'edit'
    else
      if @painting.update_attributes(painting_params)
        flash[:success] = "The paint updated"
        redirect_to painting_url
      else
        render 'edit'
      end
    end
  end
  
  def destroy
    @painting = Painting.find(params[:id])
    if @painting.present?
      @painting.destroy
    end
    flash[:success] = "Your the Painting deleted"
    redirect_to current_user
  end

  def search
    # titleとリダイレクト用
    @search_tag = params[:tag]
    # title以外の実装用
    @convert_tags = params[:tag].gsub(/[\s　]/, ',')

    @feed_items = Painting.where(purchase_id: nil,activated: true).tagged_with("#{@convert_tags}").paginate(:page => params[:page], :per_page => 30).order(id: :desc)
    unless @feed_items.any?
      flash[:unknown_tag] = "お探しのタグは見つかりませんでした。" 
      redirect_to root_url(tag: @search_tag)
    end
  end

  def admin
    admin_user
    @user = current_user
    @gallery_items = Painting.where(activated: false).paginate(:page => params[:page], :per_page => 30).order(id: :desc)
  end

  def admin_update
    admin_user
    @painting = Painting.find(params[:id])
    if @painting.update_attributes(activated: params[:activated])
      flash[:success] = "The paint activated"
      redirect_to paintings_admin_path
    else
      flash[:failed] = "Activating failed"
      redirect_to paintings_admin_path
    end
  end

  
  private
    
    def painting_params
      params.require(:painting).permit(:description, :picture, :price, :tag_list)
    end

    def painting_judge_params
      params.require(:painting).permit(:activated)
    end

    def correct_user
        @painting = current_user.paintings.find_by(id: params[:id])
        redirect_to root_url if @painting.nil?
    end

    def no_judging_paint
        redirect_to current_user if current_user.paintings.where(activated: false).count > 0
    end

end