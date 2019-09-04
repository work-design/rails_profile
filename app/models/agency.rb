class Agency < ApplicationRecord
  include RailsProfile::Agency
end unless defined? Agency
