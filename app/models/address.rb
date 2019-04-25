class Address < ApplicationRecord
  include RailsProfile::Address
end unless defined? Address
