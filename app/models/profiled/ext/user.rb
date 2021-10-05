module Profiled
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_many :profiles, class_name: 'Profiled::Profile', inverse_of: :user
      #has_many :proteges, through: :profiles
      #has_many :maintains, through: :proteges, source: :maintains

      has_many :address_users, class_name: 'Profiled::AddressUser', inverse_of: :user, dependent: :delete_all
      has_many :addresses, class_name: 'Profiled::Address', through: :address_users
      has_many :principal_address_users, -> { where(role: 'principal') }, class_name: 'Profiled::AddressUser', dependent: :delete_all
      has_many :principal_addresses, class_name: 'Profiled::Address', through: :principal_address_users, source: :address
    end

  end
end
