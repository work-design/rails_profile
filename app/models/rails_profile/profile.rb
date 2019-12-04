# frozen_string_literal: true

module RailsProfile::Profile
  extend ActiveSupport::Concern
  included do
    attribute :identity, :string
    attribute :birthday_type, :string, default: 'solar'
    attribute :birthday, :date
    attribute :gender, :string
    
    belongs_to :organ, optional: true
    belongs_to :user, optional: true
    belongs_to :account, primary_key: :identity, foreign_key: :identity, optional: true

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
