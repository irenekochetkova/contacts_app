class ContactsController < ApplicationController

  

  def index
    if current_user
      contacts = current_user.contacts
    # contacts = Contact.all

    # search = params[:search]
    # if search
    #   contacts = contacts.where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ? OR bio LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    # end

    render json: contacts.as_json
  else 
    render json: []
  end
end


def show
    contact = Contact.find_by(id: params[:id])
    render json: contact.as_json
  end

  def create
    contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      user_id: current_user.id
      )
    if contact.save
      render json: contact.as_json
    else 
      render json: {errors: contact.errors.full_massage, status: 422}
    end
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.update(
      first_name: params[:first_name] || contact.first_name,
      middle_name: params[:middle_name] || contact.middle_name,
      last_name: params[:last_name] || contact.last_name,
      email: params[:email] || contact.email,
      phone_number: params[:phone_number] || contact.phone_number,
      bio: params[:bio] || contact.bio
      )
   if contact.save
    render json: contact.as_json
  else 
    render json: {errors: contact.errors.full_massage, status: :unprocessable_entity}
  end
end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
    render json: {message: "Product successfully destroed contact ##{contact.id}."}
    
  end

end
