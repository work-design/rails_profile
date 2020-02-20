class AddressUser < ApplicationRecord
  include RailsProfile::AddressUser
end unless defined? AddressUser
