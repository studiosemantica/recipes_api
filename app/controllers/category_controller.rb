class CategoryController < ApplicationController

  # def sample
  #   render :json => {
  #       :response => "This is my input"
  #   }
  # end

  def index
    @categories = Category.all

    # let's check if we don't have an empty table
    if @categories.empty?
      render json: {
          'error': 'oops, there is no data to show'
      }
    else
      render :json => {
          :response => "successful",
          :data => @categories
      }
    end
  end

  # this method will create a new category
  # make sure to pass the category_params when you create the new category object
  def create
    #here we are creating a new single to do object
    @new_category = Category.new(category_params)

    if @new_category.save
      render :json => {
          :response => "successfully created new category",
          :data => @new_category
      }
    else
      render :json => {
          :error => 'cannot save the data'
      }
    end
  end

  def show
    @category = Category.exists?(params[:id])
    # if yes, let's display the data
    if @category
      render :json => {
          :response => 'successful',
          :data => Category.find(params[:id])
      }
    else
      # if not, let's handle the error
      render :json => {
          :response => 'record not found',
      }
    end
  end


  def destroy
    if (@category_delete = Category.find_by_id(params[:id])).present?
      @category_delete.destroy
      render :json => {
          :response => 'Successfully deleted record'
      }
    else
      render :json => {
          :response => 'Record not found'
      }
    end
  end


  def update
    @category_update = Category.find(params[:id])
    if @category_update.update(category_params)
      render :json => {
          :response => 'successfully updated the data',
          :data => @category_update
      }
    else
      render :json => {
          :response => 'cannot update the selected record'
      }
    end
  end

  # never trust any user inputs, we must whitelist the incoming keys

  private

  def category_params
    params.permit(:id, :title, :description, :created_by)
  end
end

