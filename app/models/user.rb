class User < ActiveRecord::Base
	
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatoble

	attr_accessible :login, :email, :password, :password_confirmation, :remember_me

	has_one :cart
	has_many :order
end
