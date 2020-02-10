class PaintingsController < ApplicationController
  def create
    @painting = current_user.paintings.build #build(painting_params)
    if @painting.save
      flash[:success] = "painting created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  #def show
  #  @painting = Painting.new
  #  render "new"
  #end
    
  def destroy
  end
    
  private
    
    def painting_params
      params.require(:painting).permit(:description, :)
    end
end