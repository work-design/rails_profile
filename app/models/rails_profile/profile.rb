# frozen_string_literal: true

module RailsProfile::Profile
  extend ActiveSupport::Concern
  included do
    attribute :first_name, :string
    attribute :real_name, :string
    attribute :nick_name, :string
    attribute :birthday_type, :string, default: 'solar'
    attribute :birthday, :date
    attribute :gender, :string
    attribute :note, :string
    attribute :address, :string
    attribute :extra, :json
  
    belongs_to :user, optional: true
    belongs_to :account, primary_key: :identity, foreign_key: :identity, optional: true

    belongs_to :area, optional: true
    has_one_attached :resume
    has_one_attached :avatar

    validates :identity, uniqueness: { scope: :organ_id }, allow_blank: true

    enum birthday_type: {
      solar: 'solar',
      lunar: 'lunar'
    }
    enum gender: {
      male: 'male',
      female: 'female',
      unknown: 'unknown'
    }
    
    after_initialize if: :new_record? do
      self.real_name ||= user.name
    end
    
    has_taxons :area
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
    avatar.service_url if avatar.attachment.present?
  end
  
  def init_user
    account || build_account
    account.user || account.build_user
    self.user = account.user
    
    self.class.transaction do
      self.save!
      account.save!
    end
    
    user
  end

end
