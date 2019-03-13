class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  has_one_attached :resume

  enum birthday_type: {
    gregorian: '',
    lunar: 'lunar'
  }
  enum gender: {
    male: 'mail',
    female: 'female'
  }

  def age
    return 0 unless self.birthday
    r_hash = TimeHelper.exact_distance_time(self.birthday, Date.today)
    r_hash[:year]
  end

end unless RailsProfile.config.disabled_models.include?('Profile')
