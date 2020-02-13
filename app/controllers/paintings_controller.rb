class PaintingsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user,   only: :destroy
  def create
    @painting = current_user.paintings.build(painting_params)
    if @painting.save
      flash[:success] = "painting created!"
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
    
  def destroy
    @painting = Painting.find(params[:id])
    if @painting.present?
        @painting.destroy
    end
    flash[:success] = "Your the Painting deleted"
    redirect_to request.referrer || root_url
  end
    
  private
    
    def painting_params
      params.require(:painting).permit(:description, :picture)
    end

    def correct_user
        @painting = current_user.paintings.find_by(id: params[:id])
        redirect_to root_url if @painting.nil?
    end
end