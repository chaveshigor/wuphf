class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = User.find(current_user[:id]).contacts
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end
end
