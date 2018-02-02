class Group < ApplicationRecord
  has_many :group_contacts
  has_many :contacts, through: :group_contacts

  def as_json
    {
      id: id,
      title: title,
      contacts: contacts.map { |contact| contact.full_name
      }
    }
  end
end
