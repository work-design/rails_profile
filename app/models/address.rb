class Address < ApplicationRecord
  include RailsProfile::Address
  include RailsFactory::Address if defined? RailsFactory
  include RailsShip::Address if defined? RailsShip
  include RailsWait::Address if defined? RailsWait
end unless defined? Address
