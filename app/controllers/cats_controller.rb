class CatsController < ApplicationController
  
  def index
    @cats = Cat.all
    render :index  
  end
  
  def show
    @cat = Cat.find(params[:id])
    render :show
  end
  
  def new
    @cat = Cat.new
    fail
    render :new
  end
  
  def create
    @cat = Cat.new(cats_params)
    
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash[:errors] = @cat.errors.full_messages
      render :new
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end
  
  def update
    @cat = Cat.find(params[:id])
    @cat.update(cats_params)
    redirect_to cat_url(@cat)
  end
  
  private
    
  def cats_params
    params.require(:cat).permit(:age, :birth_date, :color, :name, :sex)
  end
  
end
