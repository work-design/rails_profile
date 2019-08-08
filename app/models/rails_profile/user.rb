module RailsProfile::User
  extend ActiveSupport::Concern

  included do
    has_many :profiles, inverse_of: :user
    has_many :proteges, through: :profiles
    has_many :maintains, through: :proteges, source: :maintains
  end

end
