# frozen_string_literal: true

module RailsProfile::Profile
  extend ActiveSupport::Concern
  included do
    delegate :url_helpers, to: 'Rails.application.routes'
    has_taxons :area
  
    attribute :first_name, :string
    attribute :real_name, :string
    attribute :nick_name, :string
    attribute :birthday_type, :string
    attribute :birthday, :date
    attribute :gender, :string
    attribute :note, :string
    attribute :address, :string
    attribute :extra, :json
  
    belongs_to :user, optional: true
    belongs_to :account, -> { where(confirmed: true) }, primary_key: :identity, foreign_key: :identity, optional: true

    belongs_to :area, optional: true
    has_one_attached :resume
    has_one_attached :avatar

    validates :identity, uniqueness: { scope: :organ_id }

    enum birthday_type: {
      solar: 'solar',
      lunar: 'lunar'
    }
    enum gender: {
      male: 'male',
      female: 'female'
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

  def avatar_url
    url_helpers.rails_blob_url(avatar) if avatar.attachment.present?
  end

end
