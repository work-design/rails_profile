class Area < ApplicationRecord
  include RailsProfile::Area
  include RailsTaxon::Node
end unless defined? Area
