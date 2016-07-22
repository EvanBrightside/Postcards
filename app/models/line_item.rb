class LineItem < ActiveRecord::Base
	validates :product_id, presence: true

  belongs_to :product
  belongs_to :cart
end
