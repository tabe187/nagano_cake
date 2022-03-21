class Address < ApplicationRecord
  
  belongs_to :customer
  
  def view_address_and_name
   "〒" + self.postal_code + "   " + self.address + "   " + self.name
  end
  
end
