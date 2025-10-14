class ContactMailer < ApplicationMailer
  default to: "info@djgriffiths.co.uk"  

  def new_contact(contact)
    @contact = contact
    mail(from: @contact.email, subject: "New Contact Form Message from #{@contact.name}")
  end
end