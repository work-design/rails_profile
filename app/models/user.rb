class User < ApplicationRecord
  include RailsProfile::User
end unless defined? User
