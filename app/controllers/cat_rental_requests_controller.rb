class CatRentalRequestsController < ApplicationController
  
  def index
    @cat_rental_requests = CatRentalRequest.all.order(:start_date)
    render :index  
  end
  
  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :show
  end
  
  def new
    @cat_rental_request = CatRentalRequest.new

    render :new
  end
  
  def create
    @cat_rental_request = CatRentalRequest.new(rental_request_params)
    @cat_rental_request.user_id = current_user.id
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      flash[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end
  
  def edit
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :edit
  end
  
  def update
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.update(rental_request_params)
    redirect_to cat_url(@cat_rental_request)
  end
  

  
  private
    
  def rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
