class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
    @genres = Genre.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_items_path
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_items_path
  end

  def show
    @item = Item.find(params[:id])
    @genre = Genre.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :genre_id, :name, :introduction, :price, :is_active)
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

end
