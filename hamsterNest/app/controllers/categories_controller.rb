class CategoriesController < ApplicationController
  def index
    @categories = Item.all
  end
end
