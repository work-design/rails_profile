module RailsCrm::Tutelage
  extend ActiveSupport::Concern
  
  included do
    attribute :relation, :string, default: 'unknown'
    
    belongs_to :tutelar, class_name: 'Profile', foreign_key: :tutelar_id, inverse_of: :proteges
    belongs_to :pupil, class_name: 'Profile', foreign_key: :pupil_id # for autosave
    has_one :maintain, inverse_of: :tutelage
    has_many :maintains
    has_many :crowd_students
    has_many :crowds, through: :crowd_students
    has_many :cards, dependent: :nullify
    
    accepts_nested_attributes_for :tutelar, reject_if: :all_blank
    accepts_nested_attributes_for :pupil, reject_if: :all_blank
  
    enum relation: {
      son: 'son',
      grandson: 'grandson',
      nephew: 'nephew',
      unknown: 'unknown'
    }
  
    before_validation :sync_pupil_and_tutelar, if: -> { self.maintain.present? }
  end

  def join_crowd(crowd_id)
    cs = self.crowd_students.build
    cs.student = pupil
    cs.crowd_id = crowd_id
    cs.save
  end

  def name
    "#{relation_i18n} #{pupil.real_name}"
  end
  
  def sync_pupil_and_tutelar
    self.tutelar = maintain.tutelar
    self.pupil = maintain.client
  end

  def set_major
    self.class.transaction do
      self.update(major: true)
      self.class.where.not(id: self.id).where(pupil_id: self.pupil_id).update_all(major: false)
    end
  end

end
