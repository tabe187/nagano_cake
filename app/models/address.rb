class Address < ApplicationRecord
  belongs_to :customer

  def view_address_and_name
    "〒" + postal_code + "   " + address + "   " + name
  end
end
