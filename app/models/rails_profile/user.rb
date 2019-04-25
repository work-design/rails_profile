module RailsProfile::User
  extend ActiveSupport::Concern

  included do
    has_one :profile
    has_many :profiles, inverse_of: :user
  end

end
