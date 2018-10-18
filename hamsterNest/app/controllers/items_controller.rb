# todo: add current user as the
class ItemsController < ApplicationController
  respond_to :json, :js, :html
  def index
    @search = Item.ransack(params[:q])
    @items = @search.result(distinct: true)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_path
  end
end

private
def item_params
      params.require(:item).permit(:item_name, :category_id, :status, :search_text)
    end
