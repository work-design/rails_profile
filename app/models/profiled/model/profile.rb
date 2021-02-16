# frozen_string_literal: true
module Profiled
  module Model::Profile
    extend ActiveSupport::Concern

    included do
      attribute :birthday, :date
      attribute :real_name, :string
      attribute :nick_name, :string

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :user, class_name: 'Auth::User', optional: true

      enum birthday_type: {
        solar: 'solar',
        lunar: 'lunar'
      }, _default: 'solar'

      enum gender: {
        male: 'male',
        female: 'female',
        unknown: 'unknown'
      }

      has_one_attached :avatar
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
end
