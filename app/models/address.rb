module Profiled
  class Address < ApplicationRecord
    include Model::Address
    include Factory::Model::Address if defined? RailsFactory
    include Ship::Model::Address if defined? RailsShip
    include Wait::Model::Address if defined? RailsWait
  end
end
