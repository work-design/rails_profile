module RailsProfile::User
  extend ActiveSupport::Concern

  included do
    has_many :profiles, inverse_of: :user
    #has_many :proteges, through: :profiles
    #has_many :maintains, through: :proteges, source: :maintains

    has_many :address_users, dependent: :delete_all
    has_many :addresses, through: :address_users
  end

end
