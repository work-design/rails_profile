# frozen_string_literal: true
module Profiled
  module Share::Age
    extend ActiveSupport::Concern

    included do
      attribute :birthday, :date

      enum birthday_type: {
        solar: 'solar',
        lunar: 'lunar'
      }, _default: 'solar'

      enum gender: {
        male: 'male',
        female: 'female',
        unknown: 'unknown'
      }

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :account, -> { where(confirmed: true) }, class_name: 'Auth::Account', foreign_key: :identity, primary_key: :identity, optional: true
      belongs_to :user, class_name: 'Auth::User', optional: true

      has_one_attached :avatar
    end

    def age
      return 0 unless self.birthday
      r_hash = TimeHelper.exact_distance_time(self.birthday, Date.today)
      r_hash[:year]
    end

    def age_str
      return '' unless self.birthday
      r_hash = TimeHelper.exact_distance_time(self.birthday, Date.today)
      "#{r_hash[:year]}岁#{r_hash[:month]}月"
    end

    def enter_url
      Rails.application.routes.url_for(
        controller: 'profiled/profiles',
        action: 'qrcode',
        id: self.id,
        host: organ.host
      )
    end

    def qrcode_enter_png
      QrcodeHelper.code_png(enter_url, border_modules: 0, fill: 'pink')
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

  end
end
