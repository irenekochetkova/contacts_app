class ContactsController < ApplicationController

  def show
    contact = Contact.find_by(id: params[:id])
    render json: contact.as_json
  end

  def index
    contact = Contact.all
    render json: contact.as_json
  end

  def create
    contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number]
      )
    contact.save
    render json: contact.as_json
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.update(
      first_name: params[:first_name] || contact.first_name,
      last_name: params[:last_name] || contact.last_name,
      email: params[:email] || contact.email,
      phone_number: params[:phone_number] || contact.phone_number
      )
    render json: contact.as_json
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
    render json: {message: "Product successfully destroed."
    }
  end

end
