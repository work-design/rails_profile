module Profiled
  module Model::User
    extend ActiveSupport::Concern

    included do
      has_many :profiles, inverse_of: :user
      #has_many :proteges, through: :profiles
      #has_many :maintains, through: :proteges, source: :maintains

      has_many :address_users, dependent: :delete_all
      has_many :addresses, through: :address_users
      has_many :principal_address_users, -> { where(role: 'principal') }, class_name: 'AddressUser', dependent: :delete_all
      has_many :principal_addresses, through: :principal_address_users, source: :address
    end

  end
end
