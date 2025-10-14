module Super
  class ContactsController < ApplicationController
    def index
      @contacts = Contact.order(created_at: :desc)
    end

    def show
      @contact = Contact.find(params[:id])
    end

    def destroy
      @contact = Contact.find(params[:id])
      @contact.destroy
      redirect_to super_contacts_path, notice: "Message deleted."
    end
  end
end
