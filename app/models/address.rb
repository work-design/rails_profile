class Address < ApplicationRecord
  include RailsProfile::Address
  include RailsFactory::Address if defined? RailsFactory
end unless defined? Address
