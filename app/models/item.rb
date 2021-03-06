class Item < ApplicationRecord
  has_one_attached :item_image

  # belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  belongs_to :genre

  # def get_item_image(width, height)
  # item_image.variant(resize_to_limit: [width, height]).processed
  # end

  def get_item_image(width, height)
    item_image.variant(resize_to_limit: [width, height]).processed
  end

  def taxin_price
    price * 1.1
  end
end
