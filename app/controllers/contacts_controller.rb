class ContactsController < ApplicationController

  def first_contact_method
    contact = Contact.first
    render json: contact.as_json
  end

  def all_contacts_method
    contact = Contact.all
    render json: contact.as_json
  end
     
end
