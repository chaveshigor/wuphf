class ContactsController < ApplicationController
	before_action :authenticate_user!

	def index
		@contacts = User.find(current_user[:id]).contacts
	end

	def show
		@contact_to_show = Contact.find(params[:id])
	end

	def new
		@current_contact = Contact.new
	end

	def create
		@current_contact = Contact.new(contact_params)
		@current_contact[:user_id] = current_user[:id]

		if @current_contact.save
			redirect_to contact_path(@current_contact)
		end
	end

	def update
	end

	def edit
	end

	def destroy
	end

	private
	
	def contact_params
		params.require(:contact).permit(:first_name, :last_name, :email, :telegram_profile, :phone_number, :gender)
	end
end
