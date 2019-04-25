class Profile < ApplicationRecord
  include RailsProfile::Profile
end unless defined? Profile
