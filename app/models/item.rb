class Item < ActiveRecord::Base
	validates :price, numericality: { greater_than: 0, allow_nil: true }
	validates :name, :description, presence: true
	validates :name, presence: true
	after_initialize { puts "initialized" } # Item.new; Item.first
	after_save       { puts "saved" } # Item.save; Item.create; item.update_attributes()
	after_create     { puts "created" }
	after_update     { puts "updated" }
	after_destroy    { puts "destroyed" } # item.destroy
end
