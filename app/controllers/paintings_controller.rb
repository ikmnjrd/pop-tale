class PaintingsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user,   only: :destroy #必要？？
    before_action :no_judging_paint, only: :create

  def create
    @painting = current_user.paintings.build(painting_params)
    if @painting.save
      flash[:success] = "painting created!"
      JudgmentMailer.new_registration(@painting).deliver_now
      flash[:info] = "まだ審査中だから待ってな！！"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
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
    if @painting.update_attributes(painting_params)
      flash[:success] = "The paint updated"
      redirect_to painting_url
    else
      render 'edit'
    end
  end
  
  def destroy
    @painting = Painting.find(params[:id])
    if @painting.present?
        @painting.destroy
    end
    flash[:success] = "Your the Painting deleted"
    redirect_to request.referrer || root_url
  end

  def search
    @search_tag = params[:tag]
    @feed_items = Painting.tagged_with("#{params[:tag]}")
  end
    
  private
    
    def painting_params
      params.require(:painting).permit(:description, :picture, :price, :tag_list)
    end

    def correct_user
        @painting = current_user.paintings.find_by(id: params[:id])
        redirect_to root_url if @painting.nil?
    end

    def no_judging_paint
        redirect_to current_user if current_user.paintings.where(activated: false).count > 0
    end

end