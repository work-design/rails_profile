module RailsProfileUser
  extend ActiveSupport::Concern

  included do
    has_many :profiles, inverse_of: :user
  end



end
