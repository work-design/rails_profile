class Area < ApplicationRecord
  include RailsProfile::Area
  include RailsCom::Taxon
end unless defined? Area
