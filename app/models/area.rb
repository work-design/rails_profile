class Area < ApplicationRecord
  include RailsProfile::Area
  prepend RailsTaxon::Node
end unless defined? Area
