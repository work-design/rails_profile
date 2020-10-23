# frozen_string_literal: true
module RailsProfile::Profile
  extend ActiveSupport::Concern

  included do
    attribute :birthday_type, :string, default: 'solar'
    attribute :birthday, :date
    attribute :gender, :string
    attribute :real_name, :string
    attribute :nick_name, :string

    belongs_to :organ, optional: true
    belongs_to :user, optional: true

    has_one_attached :avatar

    enum birthday_type: {
      solar: 'solar',
      lunar: 'lunar'
    }
    enum gender: {
      male: 'male',
      female: 'female',
      unknown: 'unknown'
    }
  end

  def age
    return 0 unless self.birthday
    r_hash = TimeHelper.exact_distance_time(self.birthday, Date.today)
    r_hash[:year]
  end

  def age_str
    return '未知' unless self.birthday
    r_hash = TimeHelper.exact_distance_time(self.birthday, Date.today)
    "#{r_hash[:year]}岁#{r_hash[:month]}月"
  end

end
