class Profile < ApplicationRecord
  include RailsProfileUser
  belongs_to :user, inverse_of: :profile
  has_one_attached :resume


end unless RailsProfile.config.disabled_models.include?('Profile')
