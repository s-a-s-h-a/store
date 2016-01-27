class ItemsController < ApplicationController

	before_filter :find_item, only: [:show, :edit, :update, :destroy, :upvote]
	before_filter :check_if_admin, only: [:edit, :update, :new, :create, :destroy]


	def index
		@items = Item.all
	end

	def expensive
		@items = Item.where("price > 1000")
		render "index"
	end

	#/items/1 GET - Показує конкретний товарз з бази даних
	def show
		#unless @item = Item.where(id: params[:id]).first
			unless @item
			render text: "Page not found", status: 404
		end
	end

	# /items/new GET - Рендерить нову форму длф створення товару
	def new
		@item = Item.new
	end


	#/items/1/edit GET - Рендерить форму для існуючого товара
	def edit
		#@item = Item.find(params[:id])
	end

	# /items POST - Створення запису в базі даних
	def create
		item_params = params.require(:item).permit(:price, :name, :real, :weight, :description)
		@item = Item.create(item_params)
			if @item.errors.empty?
				redirect_to item_path(@item)
			else
				render "new"
			end
	end

	# /items/1 PUT - Спочатку находить існуючий запис в базі даних, обновить
	def update
			item_params = params.require(:item).permit(:price, :name, :real, :weight, :description)
		#@item = Item.find(params[:id])
		@item.update_attributes(params.require(:item).permit(:price, :name, :real, :weight, :description))
			if @item.errors.empty?
				redirect_to item_path(@item)
			else
				render "edit"
			end	
	end

	# /items/1 DELETE - Спочатку найдер існуючий запис в базі даних а потім видалить
	def destroy
		#@item = Item.find(params[:id])
		@item.destroy
		redirect_to action: "index"
	end

	def upvote
		@item.increment!(:votes_count)
		redirect_to action: :index
	end

	private

		def find_item
			@item = Item.where(id: params[:id]).first
			render_404 unless @item
		end

end
