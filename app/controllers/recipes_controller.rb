class RecipesController < ApplicationController
  before_action :authorized

  def index
    # this commented out method will show all recipes for ONLY the specified category
    # @recipes = Recipe.where(category_id:Category.find(params[:category_id]))
    @recipes = Recipe.all

    if @recipes.empty?
      render :json => {
          :error => "No recipes to show, please create one."
      }
    else
      render :json => {
          :status => "successful",
          :data => @recipes
      }
    end
  end

  def create
    @new_recipe = Recipe.new(recipe_params)
    #here we are creating a new single recipe
    if Category.exists?(@new_recipe.category_id)
      if @new_recipe.save
        render :json => {
            :status => "successfully created a new recipe",
            :data => @new_recipe
        }
      else
        render :json => {
            :status => "cannot save the data"
        }
      end
    else
      render :json => {
          :error => "cannot add to non-existent category"
      }
    end
  end

  def show
    @recipe = Recipe.exists?(params[:id])
    if @recipe
      render :json => {
          :status => "Recipe selected",
          :data => Recipe.find(params[:id])
      }
    else
      render :json => {
          :error => "Cannot find recipe #{params[:id]}"
      }
    end
  end

  def update
    if (@recipe_update = Recipe.find(params[:id])).present?
      @recipe_update.update(recipe_params)
      render :json => {
          :status => "Recipe updated",
          :data => @recipe_update
      }
    else
      render :json => {
          :error => "Cannot find recipe #{params[:id]}"
      }
    end
  end

  def destroy
    if (@recipe_delete = Recipe.find(params[:id])).present?
      @recipe_delete.destroy
      render :json => {
          :status => "Successfully deleted recipe",
          :data => @recipe_delete
      }
    else
      render :json => {
          :error => "Recipe  #{params[:id]} not deleted"
      }
    end
  end

  private

  def recipe_params
    params.permit(:id, :name, :ingredients, :directions, :notes, :tags, :category_id)
  end

end