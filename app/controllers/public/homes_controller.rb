class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(id: "DESC")
    @genres = Genre.all
  end

  def about
  end
end
