class Contact < ApplicationRecord

  def friendly_updated_at
    updated_at.strftime("%A, %d %b %Y %l:%M %p")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def as_json
    {
      id: id,
      full_name: full_name,
      email: email,
      phone_number: phone_number,
      updated_at: friendly_updated_at      
    }
  end
end
