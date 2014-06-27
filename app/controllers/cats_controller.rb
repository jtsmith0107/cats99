class CatsController < ApplicationController
  before_action :editor_owns_cat, only: [:edit, :update]
  
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
    render :new
  end
  
  def create
    @cat = Cat.new(cats_params)
    @cat.user_id = current_user.id
    
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
    params.require(:cat).permit(:age, :birth_date, :color, :name, :sex, :user_id)
  end
  
  def editor_owns_cat
    @cat = Cat.find(params[:id]) 
    unless @cat.user_id == current_user.id
      flash[:errors] = ["Only owners can edit/update cat info."]
      redirect_to cats_url
    end
  end
  
end
