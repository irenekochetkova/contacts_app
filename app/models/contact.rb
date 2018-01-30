class Contact < ApplicationRecord

  belongs_to :user

  validates :first_name, presence: true, uniqueness: true
  validates :last_name, presence: true, uniqueness: true
 
  validates :email,  uniqueness: true

  


  def friendly_updated_at
    updated_at.strftime("%A, %d %b %Y %l:%M %p")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def japan_phone_number
    "+81 #{phone_number}"
  end



  def as_json
    {
      id: id,
      full_name: full_name,
      email: email,
      phone_number: phone_number,
      updated_at: friendly_updated_at,
      japan_phone_number: japan_phone_number,
      bio: bio 


    }
  end
end
